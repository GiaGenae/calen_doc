class DoctorsController < ApplicationController

    before_action :redirect_if_not_logged_in

    def index
        @doctors = Doctor.all.order("last_name ASC")
    end


end
