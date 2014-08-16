require 'faraday'
require 'faraday_middleware'
require 'billys_billing/x_access_token_authentication'
require 'billys_billing/utils'

require 'billys_billing/client/accounts'
require 'billys_billing/client/contacts'
require 'billys_billing/client/organizations'
require 'billys_billing/client/postings'
require 'billys_billing/client/products'
require 'billys_billing/client/transactions'
require 'billys_billing/client/users'

module BillysBilling
  class Client
    class Error < ::StandardError; end
    include BillysBilling::Utils

    include BillysBilling::Client::Accounts
    include BillysBilling::Client::Contacts
    include BillysBilling::Client::Organizations
    include BillysBilling::Client::Postings
    include BillysBilling::Client::Products
    include BillysBilling::Client::Transactions
    include BillysBilling::Client::Users

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
      body = response.body
      return body if response.success?
      raise Error, body
    end

    def path_with_query_string( start, filter )
      if filter.size > 0 then
        query = filter.map { |k,v| "#{snake_to_camel(k)}=#{v}" }.join('&')
        [ start, query ].join('?')
      else
        start
      end
    end

  end

  def self.client(url: ::BillysBilling::Client.url, token: ::BillysBilling::Client.token)
    @client ||= ::BillysBilling::Client.new( url: url, token: token )
  end
end

