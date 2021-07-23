class SessionsController < ApplicationController

    def index
    end

    def new 
    end

    def create
        if params[:provider] == "google_oauth2"
          @user = User.from_omniauth(response)
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          @user = User.find_by(email: params[:user][:email])
    
          if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
          else
            flash[:error] = "Invalid credentials. Please try again."
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
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            flash[:error] = "Google authorization was not successful."
            redirect_to '/login'
        end
    end
    
    private
    
    # def auth
    #     request.env['omniauth.auth']
    # end
end