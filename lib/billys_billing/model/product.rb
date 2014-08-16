require 'billys_billing/model'
module BillysBilling
  class Model
    class Product < Model
      include BelongsToOrganization
    end
  end
end
