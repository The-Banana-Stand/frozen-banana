class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "60x60>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, :in => 0.megabytes..4.megabytes
  has_secure_password
  has_paper_trail ignore: [:remember_digest]
  monetize :price_cents
  auto_strip_attributes :first_name, :last_name, :dm_evaluating, :sp_product_service,
                        :company_name, :company_address, :ar_comments, :sp_small_revenue_examples,
                        :sp_medium_revenue_examples, :sp_large_revenue_examples

  attr_accessor :remember_token, :activation_token, :reset_token

  BOTTOM_LINE_ENUM_VALUES = {
      '$500': 0,
      '$1,000': 1,
      '$3,000': 2,
      '$5,000': 3,
      '$10,000': 4,
      '$15,000': 5,
      '$30,000': 6,
      '$50,000': 7,
      '$75,000': 8,
      '$100k': 9,
      '$150k': 10,
      '$200k': 11,
      '$250k': 12,
      '$300k': 13,
      '$400k': 14,
      '$500k': 15,
      '$750k': 16,
      '$1 mil': 17,
      '$2 mil': 18,
      '$3 mil': 19,
      'greater than $3 mil': 20
  }

  enum dm_min_bottom_line_impact: BOTTOM_LINE_ENUM_VALUES, _prefix: true
  enum sp_small_revenue: BOTTOM_LINE_ENUM_VALUES, _prefix: true
  enum sp_medium_revenue: BOTTOM_LINE_ENUM_VALUES, _prefix: true
  enum sp_large_revenue: BOTTOM_LINE_ENUM_VALUES, _prefix: true
  enum sp_sales_cycle: {
      '1 month': 0, '2 months': 1, '3 months': 2, '4 months': 3, '5 months': 4, '6 months': 5, '7 months': 6,
      '8 months': 7, '9 months': 8, '10 months': 9, '11 months': 10, '12 months': 11
  }
  CLOSE_PERCENTAGE_ENUM_VALUES = {
      '10%': 0,
      '20%': 1,
      '30%': 2,
      '40%': 3,
      '50%': 4,
      '60%': 5,
      '70%': 6,
      '80%': 7,
      '90%': 8
  }
  enum sp_close_percentage: CLOSE_PERCENTAGE_ENUM_VALUES, _prefix: true
  enum sp_organization_close_percentage: CLOSE_PERCENTAGE_ENUM_VALUES, _prefix: true

  # Associations
  has_many :general_availabilities, -> { order :block }, inverse_of: :user, dependent: :destroy
  has_many :active_blocks, -> {where.not(start_time: nil, end_time: nil)}, class_name: 'GeneralAvailability'
  accepts_nested_attributes_for :general_availabilities
  has_many :dm_feedbacks, foreign_key: :dm_id, class_name: 'Feedback'
  has_many :sp_feedbacks, foreign_key: :sp_id, class_name: 'Feedback'
  has_many :dm_meetings, foreign_key: :dm_id, class_name: 'Meeting', dependent: :destroy
  has_many :sp_meetings, foreign_key: :sp_id, class_name: 'Meeting', dependent: :destroy
  has_many :change_requests
  has_many :invites
  has_many :payer_transactions, foreign_key: :payer_id, class_name: 'StripeTransaction'
  has_many :payee_transactions, foreign_key: :payee_id, class_name: 'StripeTransaction'
  # Callbacks
  before_save {self.email = email.downcase if email}
  before_create :create_activation_digest
  after_create :send_slack_notification, :create_general_availabilities

  # Validations
  validates :first_name, :last_name, :title, :company_name, :company_address,
            :city, :state, :zip_code, :phone_number, :role, :dm_min_bottom_line_impact, presence: true

  validates :username, presence: true, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  #Scopes
  scope :activated, ->(boolean = true) {where(activated: boolean)}
  scope :is_decision_maker, -> {where(role: %w(dm both))}


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def all_meetings
    Meeting.where(dm_id: id).or(Meeting.where(sp_id: id))
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end



  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    self.reset_sent_at < 2.hours.ago
  end

  #combines First and Last name
  def full_name
    self.first_name.capitalize + ' ' + self.last_name.capitalize if self.first_name && self.last_name
  end

  def name
    full_name
  end

  def full_address
    self.company_address +  ' ' + self.city + ', ' + self.state + ' ' + self.zip_code
  end

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||',
        parent.table[:first_name], Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:last_name]
    )
  end

  def multi_role?
    self.role == 'both'
  end

  def process_payment_info(stripe_token)
    if self.customer_token.present?
      customer = Stripe::Customer.retrieve(self.customer_token)
      if customer.deleted?
        create_stripe_customer(stripe_token)
      else
        customer.source = stripe_token
        customer.save
      end
    else
      create_stripe_customer(stripe_token)
    end
  end

  def create_stripe_customer(stripe_token)
    customer = Stripe::Customer.create(
        :email => self.email,
        :source  => stripe_token,
        :description => "#{self.full_name} ID: #{self.id}"
    )
    self.update_attribute(:customer_token, customer.id)
  end

  def stripe_customer
    Stripe::Customer.retrieve(self.customer_token)
  end

  def plat_validation_status_enum
    %w(new validated rejected)
  end


  def platform_cut_price
    Money.new( (self.price_cents * 0.1621).round(0) )
  end

  def total_price
    Money.new( self.price + self.platform_cut_price )
  end


  private

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def create_general_availabilities
    (1..5).each do |num|

      self.general_availabilities.create(block: num, day: num)

    end
  end

  def send_slack_notification
    if Rails.env.production?

      notification = {
          text: 'New User',
          username: "Awesom-O",
          icon_emoji: ":loudspeaker:",
          fields: [
              {
                  title: 'New User',
                  value: "#{self.full_name}"
              },
              {
                  title: 'ID',
                  value: "#{self.id}"
              },
              {
                  title: 'Email',
                  value: "#{self.email}"
              },
              {
                  title: 'Company',
                  value: "#{self.company_name}"
              },
              {
                  title: 'Phone Number',
                  value: "#{self.phone_number}"
              }
          ]
      }
      SLACK.ping notification

    end
  end



end
