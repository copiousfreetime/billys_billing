require 'billys_billing/model'
module BillysBilling
  class Model
    class Product < Model
      include BelongsToOrganization
      resource_name 'products'
      entity_name   'product'

      def save
        client.create_product( self )
      end
    end
  end
end
