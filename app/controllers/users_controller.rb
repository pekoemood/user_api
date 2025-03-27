class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      cookies[:jwt] = {
        value: token,
        httponly: true,
        secure: true,
        same_site: :none
      }
      render json: { message: "アカウント作成成功" }, status: :ok
    else
      render json: { errors: "無効な認証情報" }, status: :unauthorized
    end
  end

  def profile
    render json: { user: @current_user }, status: :ok
  end

  def show
    render json: @current_user, status: :ok
  end

  private

  def user_params
    params.expect(user: [ :name, :email, :password ])
  end
end
