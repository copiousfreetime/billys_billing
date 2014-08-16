require 'billys_billing/model/account'
module BillysBilling
  class Client
    module Accounts
      def accounts( filters = {} )
        path = path_with_query_string( 'accounts', filters )
        get( path )['accounts'].map { |a| Model::Account.new( a, client: self ) }
      end

      def account( id )
        Model::Account.new( get("accounts/#{id}"), client: self )
      end
    end
  end
end
