require 'map'
require 'billys_billing/utils'
module BillysBilling
  class Model < ::Map
    include BillysBilling::Utils
    attr_reader :client

    def initialize( data, client: BillysBilling.client, &block )
      @client = client
      super( data )
    end

    private

    def method_missing( name, *args, &block )
      super
    rescue NoMethodError, NameError => error
      raise error unless camel = snake_to_camel( name )
      begin
        super( camel.to_sym, *args, &block )
      rescue NoMethodError, NameError => _
        raise error
      end
    end
  end
end

require 'billys_billing/model/belongs_to_organization'
require 'billys_billing/model/account'
require 'billys_billing/model/contact'
require 'billys_billing/model/invoice'
require 'billys_billing/model/invoice_line'
require 'billys_billing/model/organization'
require 'billys_billing/model/posting'
require 'billys_billing/model/product'
require 'billys_billing/model/transaction'
require 'billys_billing/model/user'
