require 'billys_billing/model'
module BillysBilling
  class Model
    class ProductPrice < Model
      include BelongsToOrganization
      resource_name 'productPrices'
      entity_name   'productPrice'

      def save
        client.create_product_price( self )
      end
    end
  end
end
