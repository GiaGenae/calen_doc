class Appointment < ApplicationRecord
    belongs_to :user 
    belongs_to :doctor

    accepts_nested_attributes_for :doctor

    validates :date, inclusion: { in: (Date.today..Date.today+1.years), message: "Date must be within a year from today."}


    def doctor_attributes=(attributes)
        self.doctor = Doctor.find_or_create_by(attributes) if !attributes['first_name'].empty?
        self.doctor
    end
end
