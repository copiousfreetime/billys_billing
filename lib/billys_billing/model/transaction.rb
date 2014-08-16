require 'billys_billing/model'
module BillysBilling
  class Model
    class Transaction  < Model
      include BelongsToOrganization

      def postings
        client.postings( transaction_id: transaction_id )
      end
    end
  end
end
