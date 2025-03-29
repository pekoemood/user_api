class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      cookies[:jwt] = {
        value: token,
        httponly: true,
        secure: true,
        same_site: :none,
        expire: 1.hour.from_now
      }
      render json: { user: user }, status: :ok
    else
      render json: { error: "メールアドレスかパスワードが誤っています。" }, status: :unauthorized
    end
  end

  def destroy
    cookies.delete(:jwt)
    head :no_content
  end
end
