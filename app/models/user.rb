class User < ApplicationRecord
  has_secure_password

  def generate_jwt
    JsonWebToken.encode(user_id: id)
  end
end
