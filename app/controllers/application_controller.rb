class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authenticate_user!, except: [ :create ]

  private

  def authenticate_user!
    token = cookies[:jwt]

    if token
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
    end

    render json: { errors: "Unauthorized" }, status: :unauthorized unless @current_user
  end
end
