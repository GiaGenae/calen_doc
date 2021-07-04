class ReviewsController < ApplicationController

    def new 
        @doctor = Doctor.find_by_id(params[:doctor_id])
        @review = @doctor.reviews.build
    end

    def index

    end
end
