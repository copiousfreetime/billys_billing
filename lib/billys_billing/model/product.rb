require 'billys_billing/model'
module BillysBilling
  class Model
    class Product < Model
      include BelongsToOrganization
      resource_name 'products'
      entity_name   'product'
    end
  end
end
