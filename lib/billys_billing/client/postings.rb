require 'billys_billing/model/posting'
module BillysBilling
  class Client
    module Postings
      def postings( filters = {} )
        path = path_with_query_string( 'postings', filters )
        get( path )['postings'].map { |a| Model::Posting.new( a, client: self ) }
      end

      def posting( id )
        posting_data = get("postings/#{id}")['posting']
        Model::Posting.new( posting_data, client: self )
      end
    end
  end
end
