module BillysBilling
  class Client
    module Accounts
      def accounts
       get( 'accounts' )['accounts']
      end
    end
  end
end
