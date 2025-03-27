require 'jwt'

class JsonWebToken
  SECRET_KEY = Rails.application.credentials.jwt_secret_key

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    body, = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    body.with_indifferent_access
  rescue JWT::DecodeError
    nil
  end
end
