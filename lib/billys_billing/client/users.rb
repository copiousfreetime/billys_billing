require 'billys_billing/model/user'
module BillysBilling
  class Client
    module Users
      def users
        get_entities( Model::User )
      end

      def user( id )
        get_entity( Model::User, id )
      end
    end
  end
end
