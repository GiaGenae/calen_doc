class Doctor < ApplicationRecord
    has_many :appointments
    has_many :reviews
    has_many :users, through: :appointments

    def name_and_specialty
        "#{first_name} #{last_name} - #{specialty}"
    end

    def self.alpha
        order.(:specialty)
    end

end
