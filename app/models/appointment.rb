class Appointment < ApplicationRecord
    belongs_to :user 
    belongs_to :doctor

    accepts_nested_attributes_for :doctor

    validates :date, inclusion: { in: (Date.today..Date.today+1.years)}
    # validate :no_duplicate
    # validates :appointment, uniqueness: { scope: :date, :doctor, message: " %date already has an appointment with that doctor."}

    def doctor_attributes=(attributes)
        self.doctor = Doctor.find_or_create_by(attributes) if !attributes['first_name'].empty?
        self.doctor
    end

    # def no_duplicate
    #     if Appointment.find_by(date: date, doctor_id: doctor_id)
    #         errors.add(:date, "already has an duplicate appointment. Please review.")
    #     end
    # end
end
