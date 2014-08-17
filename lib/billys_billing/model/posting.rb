require 'billys_billing/model'
module BillysBilling
  class Model
    class Posting < Model
      include BelongsToOrganization
      resource_name 'postings'
      entity_name   'posting'

      def transaction
        client.transaction( transaction_id )
      end
    end
  end
end
