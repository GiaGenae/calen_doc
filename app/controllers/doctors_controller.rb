class DoctorsController < ApplicationController

    before_action :redirect_if_not_logged_in

    def index
        @doctors = Doctor.all
    end
end
