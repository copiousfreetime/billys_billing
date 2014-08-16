require 'faraday'
require 'faraday_middleware'
require 'billys_billing/x_access_token_authentication'
require 'billys_billing/client/accounts'
require 'billys_billing/client/organization'
module BillysBilling
  class Client

    include BillysBilling::Client::Accounts
    include BillysBilling::Client::Organization

    def self.url
      "https://api.billysbilling.com/v2"
    end

    def self.token
      ENV['BILLYS_BILLING_TOKEN']
    end

    def self.default
      new(url: url, token: token)
    end

    attr_reader :connection

    def initialize(url: Client.url, token: Client.token)
      @connection = Faraday.new(:url => url) do |conn|
        conn.use     BillysBilling::XAccessTokenAuthentication, token
        conn.request :json
        conn.adapter Faraday.default_adapter
        conn.response :json
      end
    end

    def get( path, params: {} , headers: {} )
      request( :get, path, params, headers )
    end

    def delete(path, params: {}, headers: {} )
      request( :delete, path, params, headers )
    end

    def head(path, params: {}, headers: {} )
      request( :head, path, params, headers )
    end

    def put(path, body: nil, headers: {})
      request( :put, path, body, headers )
    end

    def patch(path, body: nil, headers: {})
      request( :patch, path, body, headers )
    end

    def post(path, body: nil, headers: {})
      request( :post, path, body, headers )
    end

    private

    def request(method, path, body_or_params, headers)

      @last_response = response = connection.send(method, URI::Parser.new.escape(path.to_s), body_or_params, headers )
      response.body
    end
  end
end

