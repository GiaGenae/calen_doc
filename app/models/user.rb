class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_doctors, through: :reviews, source: :doctors
    
    has_many :appointments
    has_many :doctors, through: :appointments

    has_secure_password

    validates :email, uniqueness: true, presence: true
end
