class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]

  has_paper_trail ignore: [:remember_token]
  monetize :price_cents
  auto_strip_attributes :first_name, :last_name, :dm_evaluating, :sp_product_service,
                        :company_name, :company_address, :ar_comments, :sp_small_revenue_examples,
                        :sp_medium_revenue_examples, :sp_large_revenue_examples


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
  has_many :general_availabilities, -> { order day: :asc, start_time: :asc }, inverse_of: :user, dependent: :destroy
  has_many :active_blocks, -> {where.not(start_time: nil, end_time: nil).order day: :asc, start_time: :asc}, class_name: 'GeneralAvailability'
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
  after_create :send_slack_notification, :create_general_availabilities

  # Validations
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "60x60>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, :in => 0.megabytes..4.megabytes

  validates :first_name, :last_name, :title, :company_name, presence: true

  validates :username, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  #Scopes
  scope :confirmed, -> {where('confirmed_at IS NOT NULL')}
  scope :is_decision_maker, -> {where(role: %w(dm both))}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.avatar = URI.parse(auth.info.image) if auth.info.image
      user.username = auth.info.nickname
      current_position = auth.extra.raw_info.positions.values[1].find{|p| p.isCurrent}
      user.title = current_position.title
      user.company_name = current_position.company.name
      user.role = 'dm'

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end


  def all_meetings
    Meeting.where(dm_id: id).or(Meeting.where(sp_id: id))
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
    stripe_token = set_stripe_token(stripe_token)
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

  def set_stripe_token(token)
    Rails.env.test? ? StripeMock.create_test_helper.generate_card_token : token
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

  def send_confirmation_help_request(phone_number)
    if Rails.env.production?

      notification = {
          text: 'A User needs help Confirming Email',
          username: "Awesom-O",
          icon_emoji: ":loudspeaker:",
          fields: [
              {
                  title: 'User',
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
                  value: "#{phone_number}"
              }
          ]
      }
      SLACK.ping notification

    end
  end


  private

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
