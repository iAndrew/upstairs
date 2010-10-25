class UsersController < ApplicationController

  def new
    @title = "Sign up"
    @user = User.new
    if (session[:omniauth])
      @user.apply_omniauth(session[:omniauth])
      @user.valid?  
    end
  end
  
  def create
    @user = User.new(params[:user])
    if (session[:omniauth])
      @user.apply_omniauth(session[:omniauth])
    end
    if @user.save
      session[:omniauth] = nil
      sign_in @user    
      flash[:notice] = "User created. Signed in successfully."
      redirect_to @user
    else
      @title = "Sign up"
      render :new
    end    
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.email
  end

end
