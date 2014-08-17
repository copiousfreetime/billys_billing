require 'billys_billing/model'
module BillysBilling
  class Model
    class Invoice < Model
      include BelongsToOrganization
      resource_name 'invoices'
      entity_name   'invoice'

      def contact
        client.contact( contact_id )
      end

      def postings
        client.postings( transaction_id: transaction_id )
      end

      def lines
        client.invoice_lines( invoice_id: invoice_id )
      end
    end
  end
end
