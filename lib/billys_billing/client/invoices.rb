require 'billys_billing/model/invoice'
module BillysBilling
  class Client
    module Invoices
      def invoices
        get_entities( Model::Invoice )
      end

      def invoice( id )
        get_entity( Model::Invoice, id )
      end
    end
  end
end
