# frozen_string_literal: true

# User model
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

  # Because we have some old legacy users in the database, we need to override Devises method for checking if a password is valid.
  # We first ask Devise if the password is valid, and if it throws an InvalidHash exception, we know that we're dealing with a
  # legacy user, so we check the password against the SHA1 algorithm that was used to hash the password in the old database.
  alias devise_valid_password? valid_password?
  def valid_password?(password)
    devise_valid_password?(password)
  rescue BCrypt::Errors::InvalidHash
    Digest::SHA1.hexdigest(password) == encrypted_password
  end

  def notify_of_thirsty_plant(details, subscription_hash)
    plant_name = details['plant_name']
    message_params = {
      message: {
        title: 'Your plants are thirsty!',
        body: "Your plant #{plant_name} needs watering!"
      },
      subscription: subscription_hash
    }

    PushNotificationsService.call(id, message_params)
  end
end
