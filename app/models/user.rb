class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  has_secure_password
  
  field :first_name, type: String
  field :last_name, type: String
  field :user_name, type: String
  field :email_id, type: String
  field :phone_no, type: String
  field :password_digest, type: String
  field :confirmation_token, type: String
  field :confirmation_sent_at, type: DateTime
  field :confirmed_at, type: DateTime

  validates :first_name, :presence => true,
                        :length => { minimum: 3 }
  validates :last_name, :presence => true,
                        :length => { minimum: 3 }
  validates_uniqueness_of :user_name, :presence => true,
                       :length => { minimum: 6 }
  validates :password, :presence => true,
                       :length => { minimum: 6 }
  validates_uniqueness_of :email_id, :presence => true,
                        :format => { with: URI::MailTo::EMAIL_REGEXP } 
  validates :phone_no, :presence => true,
                       :length => { :minimum => 10, :maximum => 15 }

  before_save :downcase_email

  before_create :generate_confirmation_instructions

  has_many :todo_lists, dependent: :destroy

  def downcase_email
    self.email_id = self.email_id.delete(' ').downcase
  end

  def generate_confirmation_instructions
    self.confirmation_token   = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.update_attribute(:confirmed_at , Time.now.utc)
  end
end
