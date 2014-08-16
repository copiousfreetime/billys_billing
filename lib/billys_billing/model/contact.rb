require 'billys_billing/model'
module BillysBilling
  class Model
    class Contact < Model
      include BelongsToOrganization
    end
  end
end
