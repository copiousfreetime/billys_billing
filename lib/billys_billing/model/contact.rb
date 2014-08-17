require 'billys_billing/model'
module BillysBilling
  class Model
    class Contact < Model
      include BelongsToOrganization
      resource_name 'contacts'
      entity_name   'contact'
    end
  end
end
