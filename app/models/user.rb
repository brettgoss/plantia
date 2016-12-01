class User < ActiveRecord::Base
  has_secure_password
  has_many :plants

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 4..20 }

  def self.authenticate_with_credentials(email, password)
    email = email.strip
    user = User.where('email = ?', email.downcase).first

    if user
      if user.authenticate(password)
        user
      end
    end
  end
end
