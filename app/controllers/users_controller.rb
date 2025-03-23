class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
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
