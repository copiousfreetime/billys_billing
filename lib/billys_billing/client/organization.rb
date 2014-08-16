require 'billys_billing/model/organization'
module BillysBilling
  class Client
    module Organization
      def organization( id = nil )
        org_data = if id then
                     get( "organizations/#{id}" )['organization']
                   else
                     get( "organization" )['organization']
                   end
        Model::Organization.new( org_data, client: self )
      end
    end
  end
end
