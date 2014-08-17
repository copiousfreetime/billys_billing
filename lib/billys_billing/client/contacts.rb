require 'billys_billing/model/contact'
module BillysBilling
  class Client
    module Contacts
      def contacts
        get_entities( Model::Contact )
      end

      def contact( id )
        get_entity( Model::Contact, id )
      end

      def find_contacts( q )
        find_entities( Model::Contact, q )
      end

      def create_contact( contact )
        create_entity( contact )
      end
    end
  end
end
