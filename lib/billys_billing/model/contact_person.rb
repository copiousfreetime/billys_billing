require 'billys_billing/model'
module BillysBilling
  class Model
    class ContactPerson < Model
      resource_name 'contactPersons'
      entity_name   'contactPerson'

      def contact
        client.contact( contact_id )
      end
    end
  end
end
