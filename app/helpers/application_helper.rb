module ApplicationHelper
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !!current_user
  end
end
