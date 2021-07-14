class ReviewsController < ApplicationController

    def new 
        @doctor = Doctor.find_by_id(params[:doctor_id])
        @review = @doctor.reviews.build
    end

    def create
        @review = current_user.reviews.build(review_params)
        
        if @review.save
            redirect_to doctor_reviews_path(@review)
        else
            render :new
        end
    end


    def show
        @review = Review.find_by_id(params[:id])
    end

    def index
        @reviews = Review.all
    end

    def review_params
        params.require(:review).permit(:doctor_id, :rating, :notes)
    end

    private


end
