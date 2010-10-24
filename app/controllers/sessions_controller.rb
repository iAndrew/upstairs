class SessionsController < ApplicationController
  def create    
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    self.current_user = @auth.user
    #render :text => request.env['omniauth.auth'].to_yaml
    #render :text => "Welcome, #{current_user.nickname}"
    render :text => "Welcome, #{@auth.user.nickname}"
  end
end
