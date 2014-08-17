require 'billys_billing/model/product_price'
module BillysBilling
  class Client
    module ProductPrices
      def product_prices
        get_entities( Model::ProductPrice )
      end

      def product_price( id )
        get_entity( Model::ProductPrice, id )
      end

      def find_product_prices( q )
        find_entities( Model::ProductPrice, q )
      end

      def create_product_price( product_price )
        create_entity( product_price )
      end
    end
  end
end
