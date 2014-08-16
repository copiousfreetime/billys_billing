module BillysBilling
  class Model
    module BelongsToOrganization
      def organization
        client.organization( organization_id )
      end
    end
  end
end
