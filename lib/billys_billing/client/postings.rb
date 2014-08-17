require 'billys_billing/model/posting'
module BillysBilling
  class Client
    module Postings
      def postings( filters = {} )
        get_entities( Model::Posting )
      end

      def posting( id )
        get_entity( Model::Posting, id )
      end
    end
  end
end
