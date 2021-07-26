class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        @doctor = Doctor.find_by_id(params[:doctor_id])
        @review = @doctor.reviews.build
    end

    def create
        @review = current_user.reviews.build(review_params)
        
        if @review.save
            Doctor.find_by_id(params[:doctor_id])
            redirect_to review_path(@review)
        else
            render :new
        end
    end


    def show
        @review = Review.find_by_id(params[:id])
    end

    def index
        if @doctor = Doctor.find_by_id(params[:doctor_id])
            @reviews = @doctor.reviews
        else
            @reviews = Review.all.order("rating DESC")
        end
    end

    private

    def review_params
        params.require(:review).permit(:doctor_id, :rating, :notes)
    end

end