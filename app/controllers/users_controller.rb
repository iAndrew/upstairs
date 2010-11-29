class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]

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
      if params[:user][:avatar].blank?
        redirect_to @user
      else
        redirect_to avatar_cropping_user_url(@user)
      end
    else
      @title = "Sign up"
      render :new
    end
  end

  def edit
    @title = "Edit profile"
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {
        if @user.update_attributes(params[:user])
          if params[:user][:avatar].blank?
            redirect_to @user
          else
            @title = "Avatar cropping"
            redirect_to avatar_cropping_user_url(@user)
          end
        else
          @title = "Edit profile"
          render :edit
        end
      }
      format.json {
        @user.first_name = params[:first_name]
        @user.second_name = params[:second_name]
        if @user.save()
          render :json => {:first_name => @user.first_name, :second_name => @user.second_name}
        else
          render :text => "cannot save"
        end
      }
    end
  end

  def avatar_cropping
    @title = "Avatar cropping"
    @user = User.find(params[:id])
    unless @user.avatar.exists?
      redirect_to edit_user_url(@user)
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.email
  end
end
