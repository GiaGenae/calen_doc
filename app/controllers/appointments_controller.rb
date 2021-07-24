class AppointmentsController < ApplicationController

    before_action :set_appointment, only:[:show, :edit, :update]
    before_action :redirect_if_not_logged_in

    # scope :filter_by_specialty, -> (specialty) { where specialty: specialty }
    
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
        if current_user
            @appointments = @current_user.appointments.all
        else
            render :new
        end
    end

    def show
        @appointment = Appointment.find_by_id(params[:id])
        redirect_to appointment_path if !@appointment
    end

    def edit
        @appointment = Appointment.find_by_id(params[:id])
        redirect_to appointment_path if !@appointment || @appointment.user != current_user
    end

    def update
        @appointment = Appointment.find_by_id(params[:id])
        if @appointment.update(appointment_params)
            redirect_to appointment_path(@appointment)
        else
            render :edit
        end
    end

    def destroy
        Appointment.find(params[:id]).destroy
        redirect_to appointments_path
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
