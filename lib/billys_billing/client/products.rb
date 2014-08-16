require 'billys_billing/model/product'
module BillysBilling
  class Client
    module Products
      def products
        get('products')['products'].map { |u| Model::Product.new( u, client: self ) }
      end

      def product( id )
        product_data = get("products/#{id}")['product']
        Model::Product.new( product_data, client: self )
      end
    end
  end
end
