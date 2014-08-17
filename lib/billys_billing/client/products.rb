require 'billys_billing/model/product'
module BillysBilling
  class Client
    module Products
      def products
        get_entities( Model::Product )
      end

      def product( id )
        get_entity( Model::Product, id )
      end

      def find_products( q )
        get_entities( Model::Product, "#{Model::Product.resource_name}?q=#{q}" )
      end

      def create_product( product )
        create_entity( product )
     end
    end
  end
end
