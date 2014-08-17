require 'billys_billing/model'
module BillysBilling
  class Model
    class ProductPrice < Model
      include BelongsToOrganization
      resource_name 'productPrices'
      entity_name   'productPrice'
    end
  end
end
