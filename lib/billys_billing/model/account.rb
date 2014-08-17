require 'billys_billing/model'
module BillysBilling
  class Model
    class Account < Model
      include BelongsToOrganization
      resource_name 'accounts'
      entity_name 'account'
    end
  end
end
