require 'map'
module BillysBilling
  class Model < ::Map
    attr_reader :client

    def initialize( data, client: BillysBilling.client, &block )
      @client = client
      super( data )
    end

    private

    def snake_to_camel( word )
      word = word.to_s
      return nil unless word.index('_')
      leader, *parts = word.split('_')
      parts = parts.map { |p| p.capitalize }
      parts.unshift( leader )
      parts.join('').to_sym
    end

    def method_missing( name, *args, &block )
      super
    rescue NoMethodError, NameError => error
      raise error unless camel = snake_to_camel( name )
      begin
        super( camel, *args, &block )
      rescue NoMethodError, NameError => _
        raise error
      end
    end
  end
end

require 'billys_billing/model/belongs_to_organization'
require 'billys_billing/model/account'
require 'billys_billing/model/contact'
require 'billys_billing/model/organization'
require 'billys_billing/model/posting'
require 'billys_billing/model/product'
require 'billys_billing/model/user'
