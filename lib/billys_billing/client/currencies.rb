require 'billys_billing/model/currency'
module BillysBilling
  class Client
    module Currencies
      def currencies
        get_entities( Model::Currency )
      end

      def currency( id )
        get_entity( Model::Currency, id )
      end
    end
  end
end
