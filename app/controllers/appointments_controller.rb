class AppointmentsController < ApplicationController

    def new
        @appointment = Appointment.new
        @appointment.build_doctor
    end

    def create
        @appointment = Appointment.new(appointment_params)
        @appointment.user_id = session[:user_id]
        if @appointment.save    
            redirect_to appointment_path(@appointment)
        else
            render :new
        end
    end

    private

    def appointment_params
        params.require(:appointment).permit(:date, :time, :notes, :user_id, :doctor_id, doctor_attributes: [:first_name, :last_name, :email, :specialty])
    end
end
