require 'billys_billing/model'
module BillysBilling
  class Model
    class User< Model
      include BelongsToOrganization
    end
  end
end
