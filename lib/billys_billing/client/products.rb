module BillysBilling
  class Client
    module Products
      def products
       get( 'products' )['products']
      end
    end
  end
end
