module BillysBilling
  class XAccessTokenAuthentication < Faraday::Middleware
    AUTH_HEADER = 'X-Access-Token'.freeze

    def call(env)
      env[:request_headers][AUTH_HEADER] ||= @token
      puts env.inspect
      @app.call(env)
    end

    def initialize(app, token = nil)
      super(app)
      @token = token && token.to_s
    end
  end
end
