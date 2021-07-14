class SessionsController < ApplicationController

    def index

    end

    def new 

    end

    def create
        if params[:provider] == 'google_oauth2'
            @user = User.create_by_google_omniauth(auth)
            session[:user_id] = @user.id
            redirect_to user_path(@user)

        @user = User.find_by(email: params[:user][:email])
        # if @user && @user.authenticate(params[:user][:password])
        if @user.try(:authenticate, params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = "Invalid credentials."
            redirect_to login_path
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

end