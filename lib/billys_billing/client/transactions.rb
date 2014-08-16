require 'billys_billing/model/transaction'
module BillysBilling
  class Client
    module Transactions
      def transactions
        get('transactions')['transactions'].map { |u| Model::Transaction.new( u, client: self ) }
      end

      def transaction( id )
        transaction_data = get("transactions/#{id}")['transaction']
        Model::Transaction.new( transaction_data, client: self )
      end
    end
  end
end
