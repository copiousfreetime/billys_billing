module BillysBilling
  class Client
    module Organization
      def organization
       get( 'organization' )['organization']
      end
    end
  end
end
