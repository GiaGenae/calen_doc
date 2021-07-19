class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_doctors, through: :reviews, source: :doctors
    
    has_many :appointments
    has_many :doctors, through: :appointments

    has_secure_password

    validates :first_name, uniqueness: true, presence: true
    validates :last_name, uniqueness: true, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /\A(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))\z/i}
    validates :password, length: {in: 8..100}

    def self.from_omniauth(response)
        User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
          u.first_name = response[:info][:name]
          u.email = response[:info][:email]
          u.password = SecureRandom.hex(15)
        end
    end
end
