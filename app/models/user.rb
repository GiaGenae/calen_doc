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

    def self.create_by_google_omniauth(auth)
      self.find_or_create_by(email: auth[:info][:email]) do |u|
        u.first_name = auth['info']['first_name']
        u.email = auth['info']['email']
        u.password = SecureRandom.hex
      end
    end
end 
