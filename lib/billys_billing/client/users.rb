require 'billys_billing/model/user'
module BillysBilling
  class Client
    module Users
      def users
        get('users')['users'].map { |u| ::BillysBilling::Model::User.new( u, client: self ) }
      end

      def user( id )
        user_data = get("users/#{id}")['user']
        ::BillysBilling::Model::User.new( user_data, client: self )
      end
    end
  end
end
