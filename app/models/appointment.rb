class Appointment < ApplicationRecord
    belongs_to :user 
    belongs_to :doctor

    accepts_nested_attributes_for :doctor
end
