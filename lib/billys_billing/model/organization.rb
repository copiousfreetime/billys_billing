require 'billys_billing/model'
module BillysBilling
  class Model
    class Organization < Model
      resource_name 'organizations'
      entity_name   'organization'

      def owner
        client.user( owner_user_id )
      end
    end
  end
end
