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
        else
        @user = User.find_by(email: params[:user][:email])
        # if @user && @user.authenticate(params[:user][:password])
            if @user.try(:authenticate, params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
            else
            flash[:danger] = "Invalid credentials."
            redirect_to login_path
            end
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    def omniauth
        user = User.from_omniauth(request.env['omniauth.auth'])
        if user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to '/login'
        end
    end
    
    private
    
    def auth
        request.env['omniauth.auth']
    end
end