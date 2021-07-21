class Appointment < ApplicationRecord
    belongs_to :user 
    belongs_to :doctor

    accepts_nested_attributes_for :doctor

    validates :date, inclusion: { in: (Date.today..Date.today+1.years)}
    # validate :no_duplicate
    # validates :appointment, uniqueness: { scope: :date, :doctor, message: " %date already has an appointment with that doctor."}

    def doctor_attributes=(attributes)
        self.doctor = Doctor.find_or_create_by(attributes) if !attributes['first_name', 'last_name', 'email', 'specialty'].empty?
        self.doctor
    end
end
