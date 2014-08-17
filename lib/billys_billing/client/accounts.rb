require 'billys_billing/model/account'
module BillysBilling
  class Client
    module Accounts
      def accounts
        get_entities( Model::Account )
      end

      def account( id )
        get_entity( Model::Account, id )
      end

      def find_accounts( q )
        find_entities( Model::Account, q )
      end
    end
  end
end
