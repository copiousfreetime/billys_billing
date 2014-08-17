require 'billys_billing/model'
module BillysBilling
  class Model
    class Contact < Model
      include BelongsToOrganization
      resource_name 'contacts'
      entity_name   'contact'

      def persons
        client.get_entities( Model::ContactPerson, "contactPersons?contactId=#{self['id']}" )
      end

      def find_persons( q )
        client.get_entities( Model::ContactPerson, "contactPersons?contactId=#{self['id']}&q=#{q}" )
      end
    end
  end
end
