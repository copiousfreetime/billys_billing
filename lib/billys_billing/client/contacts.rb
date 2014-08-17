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
    end
  end
end
