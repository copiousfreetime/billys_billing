require 'billys_billing/model'
module BillysBilling
  class Model
    class Transaction  < Model
      include BelongsToOrganization
    end
  end
end
