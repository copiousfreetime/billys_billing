require 'billys_billing/model'
module BillysBilling
  class Model
    class Account < Model
      def organization
        client.organization( organization_id )
      end
    end
  end
end
