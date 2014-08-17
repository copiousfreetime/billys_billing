require 'billys_billing/model'
module BillysBilling
  class Model
    class InvoiceLine < Model
      resource_name 'invoiceLines'
      entity_name   'invoiceLine'

      def invoice
        client.invoice( invoice_id )
      end

      def product
        client.product( product_id )
      end
    end
  end
end
