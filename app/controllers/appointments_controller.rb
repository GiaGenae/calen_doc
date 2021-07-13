class AppointmentsController < ApplicationController

    before_action :set_appointment, only:[:show, :edit, :update]
    before_action :redirect_if_not_logged_in
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
            @appointment.build_doctor
            render :new
        end
    end

    def index
        @appointments = Appointment.all
    end

    def show
    end

    def edit
    end

    def update
        @appointment.update(appointment_params)
        redirect_to appointment_path(@appointment)
    end


    private

    def appointment_params
        params.require(:appointment).permit(:date, :time, :notes, :user_id, :doctor_id, doctor_attributes: [:first_name, :last_name, :email, :specialty])
    end

    def set_appointment
        @appointment = Appointment.find_by(params[:id])
        redirect_to appointments_path if !@appointment
    end
end
