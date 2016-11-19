class User < ActiveRecord::Base
has_secure_password
has_many :plants

validates :name, presence: true,
                length: { minimum: 2 }

validates :email, presence: true,
                confirmation: { case_sensitive: false }

validates :password, presence: true,
                length: { in: 4..20 }

end