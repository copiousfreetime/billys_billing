require 'billys_billing/model'
module BillysBilling
  class Model
    class Account < Model
      include BelongsToOrganization
    end
  end
end
