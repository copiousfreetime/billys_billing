require 'faraday'
require 'faraday_middleware'
require 'billys_billing/x_access_token_authentication'
require 'billys_billing/utils'

require 'billys_billing/client/accounts'
require 'billys_billing/client/contacts'
require 'billys_billing/client/contact_persons'
require 'billys_billing/client/currencies'
require 'billys_billing/client/invoices'
require 'billys_billing/client/invoice_lines'
require 'billys_billing/client/organizations'
require 'billys_billing/client/postings'
require 'billys_billing/client/products'
require 'billys_billing/client/product_prices'
require 'billys_billing/client/transactions'
require 'billys_billing/client/users'

module BillysBilling
  class Client
    class Error < ::StandardError; end
    include BillysBilling::Utils

    include BillysBilling::Client::Accounts
    include BillysBilling::Client::Contacts
    include BillysBilling::Client::ContactPersons
    include BillysBilling::Client::Currencies
    include BillysBilling::Client::InvoiceLines
    include BillysBilling::Client::Invoices
    include BillysBilling::Client::Organizations
    include BillysBilling::Client::Postings
    include BillysBilling::Client::ProductPrices
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

    def get_entities( model, path = nil )
      path = path || model.resource_name
      data = get( path )[model.resource_name]
      data.map { |m| model.new( m, client: self ) }
    end

    def find_entities( model, query )
      get_entities( model, "#{model.resource_name}?q=#{query}" )
    end

    def get_entity( model, id )
      path = "#{model.resource_name}/#{id}"
      data = get( path )[ model.entity_name ]
      model_class.new(data, client: self )
    end

    def create_entity( entity )
      json = to_api_json( entity.entity_name, entity )
      data = post( entity.resource_name, body: json )[ entity.resource_name ].first
      entity.class.new( data, client: self )
    end

    private

    def request(method, path, body_or_params, headers)
      @last_response = response = connection.send(method, URI::Parser.new.escape(path.to_s), body_or_params, headers )
      body = response.body
      return body if response.success?
      raise Error, body
    end

    def to_api_json( entity_name, model )
      { entity_name => camel_hash( model ) }.to_json
    end

    def key_map( model )
      model.keys.each_with_object({}) { |key, h|
        h[key] = snake_to_camel( key ) || key
      }
    end

    def camel_hash( model )
      camel_map = key_map( model )
      Hash.new.tap { |h|
        camel_map.each_pair do |snake, camel|
          value = model.send( snake )
          if value.kind_of?( Array ) then
            value = value.map { |v1| camel_hash( v1 ) }
          end
          h[camel] = value
        end
      }
    end

  end

  def self.client(url: ::BillysBilling::Client.url, token: ::BillysBilling::Client.token)
    @client ||= ::BillysBilling::Client.new( url: url, token: token )
  end
end

