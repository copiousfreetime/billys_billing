require 'billys_billing/model/contact'
module BillysBilling
  class Client
    module Contacts
      def contacts
        get('contacts')['contacts'].map { |u| Model::Contact.new( u, client: self ) }
      end

      def contact( id )
        contact_data = get("contacts/#{id}")['contact']
        Model::Contact.new( contact_data, client: self )
      end
    end
  end
end
