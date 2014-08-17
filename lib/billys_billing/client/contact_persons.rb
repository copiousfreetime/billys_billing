require 'billys_billing/model/contact_person'
module BillysBilling
  class Client
    module ContactPersons
      def contact_persons
        get_entities( Model::ContactPerson )
      end

      def contact_person( id )
        get_entity( Model::ContactPerson, id )
      end

      def create_contact_person( contact_person )
        create_entity( contact_person )
      end
    end
  end
end
