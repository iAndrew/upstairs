class SessionsController < ApplicationController

  def new
    @title = "Sign in"
    if signed_in?
      flash[:notice] = "You are already signed in. Please sign out if you want to sign in as a different user."
    end
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination"
      @title = "Sign in"
      render :new
    else
      sign_in user
      redirect_back_or user
    end
  end

  def callback
    omniauth = request.env['omniauth.auth']
    auth = Authorization.find_from_hash(omniauth)
    if (auth)
      sign_in(auth.user) 
      redirect_to user_path(current_user)
    elsif current_user
      current_user.authorizations.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authorization added."
      redirect_to user_path(current_user)
    else
      user = User.new
      user.apply_omniauth(omniauth)      
      if user.save
        sign_in(auth.user)
        flash[:notice] = "User created. Signed in successfully."
        redirect_to user_path(current_user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_path
      end      
    end
  end

  def failure
    flash[:error] = "We had trouble signing you in. Please try again."
    render :new
  end

  def destroy
    sign_out
    flash[:notice] = "Successfully signed out."
    redirect_to root_path
  end
end
