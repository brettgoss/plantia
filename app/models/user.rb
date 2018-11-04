class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :plants
  has_many :water_events, through: :plants
  has_many :subscriptions

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # validates :password, presence: true, length: { in: 4..20 }

  # Because we have some old legacy users in the database, we need to override Devises method for checking if a password is valid.
  # We first ask Devise if the password is valid, and if it throws an InvalidHash exception, we know that we're dealing with a
  # legacy user, so we check the password against the SHA1 algorithm that was used to hash the password in the old database.
  alias :devise_valid_password? :valid_password?
  def valid_password?(password)
    begin
      devise_valid_password?(password)
    rescue BCrypt::Errors::InvalidHash
      Digest::SHA1.hexdigest(password) == encrypted_password
    end
  end
end
# or .collect return associated user. list of users thats has thirsty plants
