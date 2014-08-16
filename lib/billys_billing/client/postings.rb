require 'billys_billing/model/posting'
module BillysBilling
  class Client
    module Postings
      def postings
        get('postings')['postings'].map { |u| Model::Posting.new( u, client: self ) }
      end

      def posting( id )
        posting_data = get("postings/#{id}")['posting']
        Model::Posting.new( posting_data, client: self )
      end
    end
  end
end
