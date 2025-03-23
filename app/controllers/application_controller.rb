class ApplicationController < ActionController::API
  before_action :authenticate_user!, except: [ :create ]

  private

  def authenticate_user!
    header = request.headers["Authorization"]
    token = header.split(" ").last if header.present?

    if token
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
    end

    render json: { errors: "Unauthorized" }, status: :unauthorized unless @current_user
  end
end
