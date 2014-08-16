require 'billys_billing/model'
module BillysBilling
  class Model
    class Posting < Model
      include BelongsToOrganization

      def transaction
        client.transaction( transaction_id )
      end
    end
  end
end
