class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV['JWT_SECRET_KEY'])
    end

    def decode(token)
      body = JWT.decode(token, ENV['JWT_SECRET_KEY'])[0]
      HashWithIndifferentAccess.new body
    end
  end
end