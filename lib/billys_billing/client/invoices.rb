require 'billys_billing/model/invoice'
module BillysBilling
  class Client
    module Invoices
      def invoices
        get('invoices')['invoices'].map { |u| Model::Invoice.new( u, client: self ) }
      end

      def invoice( id )
        invoice_data = get("invoices/#{id}")['invoice']
        Model::Invoice.new( invoice_data, client: self )
      end
    end
  end
end
