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
    end
  end
end
