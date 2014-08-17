require 'billys_billing/model/invoice_line'
module BillysBilling
  class Client
    module InvoiceLines
      def invoice_lines
        get_entities( Model::InvoiceLine )
      end

      def invoice_line( id )
        get_entity( Model::InvoiceLine, id )
      end
    end
  end
end
