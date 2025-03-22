class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      token = 
    end
  end
end



private 

def user_params
  params.except(user: [ :name, :password, :password_confirm ])
end

def create_token(user_id)
  payload = {user_id: user_id}
  secret_key = Rails.application.secrets.secret_key_base[0]
end
