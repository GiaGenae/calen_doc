class Doctor < ApplicationRecord
    has_many :appointments
    has_many :reviews
    has_many :users, through: :appointments

    validates :email, uniqueness: true
end
