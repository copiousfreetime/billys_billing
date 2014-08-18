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

      def find_invoices( q )
        find_entities( Model::Invoice, q )
      end

      def create_invoice( invoice )
        create_entity( invoice )
      end
    end
  end
end
