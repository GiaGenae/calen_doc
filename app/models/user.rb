class User < ApplicationRecord
    has_many :reviews
    has_many :appointments
    has_many :doctors, through: :appointments

    has_secure_password
end
