require 'billys_billing/model/currency'
module BillysBilling
  class Client
    module Currencies
      def currencies
        get('currencies')['currencies'].map { |u| Model::Currency.new( u, client: self ) }
      end

      def currency( id )
        currency_data = get("currencies/#{id}")['currency']
        Model::Currency.new( currency_data, client: self )
      end
    end
  end
end
