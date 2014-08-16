require 'billys_billing/model/organization'
module BillysBilling
  class Client
    module Organization
      def organization
        ::BillysBilling::Model::Organization.new( get( 'organization' )['organization'], client: self )
      end
    end
  end
end
