class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorize

  def authorize
    @user = User.find_by(id: session[:user_id])
    if !@user
      render json: {errors: ["unauthorized"]}, status: :unauthorized
    end
  end

end
