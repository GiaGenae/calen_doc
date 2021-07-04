class ReviewsController < ApplicationController

    def new 
        @doctor = Doctor.find_by_id(params[:doctor_id])
        @doctor.reviews.build
    end

    def index

    end
end
