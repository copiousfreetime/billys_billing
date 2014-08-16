require 'billys_billing/model'
module BillysBilling
  class Model
    class InvoiceLine < Model
      def invoice
        client.invoice( invoice_id )
      end

      def product
        client.product( product_id )
      end
    end
  end
end
