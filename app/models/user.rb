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
  alias :devise_valid_password? :valid_password?
  def valid_password?(password)
    begin
      devise_valid_password?(password)
    rescue BCrypt::Errors::InvalidHash
      Digest::SHA1.hexdigest(password) == encrypted_password
    end
  end

  def self.get_thirsty_plants_by_user(days_since_watered = 2)
    get_users_with_recently_watered_plants(days_since_watered)

    @thirsty_plants = {}
    @users_with_recently_watered_plants.map do |user, events|
      plants = {}
      events.each do |event|
        if (!plants.include? event.plant_id) && event.water_date <= DateTime.now
          plants["#{event.plant_id}"] = event.water_date
        elsif event.water_date > DateTime.now
          plants.delete("#{event.plant_id}")
        end
      end
      @thirsty_plants["#{user}"] = plants
    end

    return @thirsty_plants
  end

private
  def self.get_users_with_recently_watered_plants(days_since_watered)
    @users_with_recently_watered_plants = {}
    User.all.each do |user|
      water_events = user.water_events.where("water_date > ?", days_since_watered.days.ago.beginning_of_day).to_a
      if water_events.any?
        @users_with_recently_watered_plants["#{user.id}"] = water_events
      end
    end
  end
end
