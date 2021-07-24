class SessionsController < ApplicationController

    def index
    end

    def new 
    end

    def create
        @user = User.find_by(email: params[:user][:email])

        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = "Invalid credentials. Please try again."
            redirect_to login_path
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    def omniauth
        @user = User.find_or_create_by(email: auth["info"]["email"]) do |user|
          user.first_name = auth["info"]["first_name"]
          user.last_name = auth["info"]["last_name"]
          user.email = auth["info"]["email"]
          user.password = SecureRandom.hex(10)
        end
        if @user.valid?
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
            flash[:error] = "Google authorization was not successful."
            redirect_to "/"
        end
      end
    
    private
    
    def auth
        request.env['omniauth.auth']
    end
end

