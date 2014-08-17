require 'billys_billing/model/transaction'
module BillysBilling
  class Client
    module Transactions
      def transactions
        get_entities( Model::Transaction )
      end

      def transaction( id )
        get_entity( Model::Transaction, id )
      end
    end
  end
end
