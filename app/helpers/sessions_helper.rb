module SessionsHelper
  def get_cookie(val)
    cookies[val]
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user
    @current_user ||= User.find_by_id(cookies.signed[:user_id])
    @current_user
  end
  
  def current_user?(user)
    current_user == user
  end
end
