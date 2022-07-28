class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base. to_s
  
    # Token expires 5 years from now
    def self.encode(payload, exp = 48.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end
  
    def self.decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
  