require 'billys_billing/model'
module BillysBilling
  class Model
    class Transaction  < Model
      include BelongsToOrganization
      resource_name 'transactions'
      entity_name   'transaction'


      def postings
        client.postings( transaction_id: transaction_id )
      end
    end
  end
end
