class User < ApplicationRecord
  has_secure_password
  has_paper_trail ignore: [:remember_digest]
  monetize :price_cents
  attr_accessor :remember_token, :activation_token, :reset_token

  # Associations
  has_many :general_availabilities, -> { order :block }, inverse_of: :user
  has_many :active_blocks, -> {where.not(start_time: nil, end_time: nil)}, class_name: "GeneralAvailability"
  accepts_nested_attributes_for :general_availabilities
  has_many :dm_feedbacks, foreign_key: :dm_id, class_name: 'Feedback'
  has_many :sp_feedbacks, foreign_key: :sp_id, class_name: 'Feedback'
  has_many :dm_meetings, foreign_key: :dm_id, class_name: 'Meeting'
  has_many :sp_meetings, foreign_key: :sp_id, class_name: 'Meeting'

  # Callbacks
  before_save {self.email = email.downcase if email}
  before_create :create_activation_digest

  # Validations
  validates :first_name, :last_name, :title, :company_name, :company_address,
            :city, :state, :zip_code, :phone_number, :role, presence: true

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

  def account_setup
    send_activation_email
    create_general_availabilities
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
    self.first_name.capitalize + ' ' + self.last_name.capitalize
  end

  def name
    full_name
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

  def create_stripe_customer(stripe_token)
    if self.customer_token.present?
      customer = Stripe::Customer.retrieve(self.customer_token)
      customer.source = stripe_token
      customer.save
    else
      customer = Stripe::Customer.create(
          :email => self.email,
          :source  => stripe_token,
          :description => self.full_name
      )
      self.update_attribute(:customer_token, customer.id)
    end
  end

  def stripe_customer
    Stripe::Customer.retrieve(self.customer_token)
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

end
