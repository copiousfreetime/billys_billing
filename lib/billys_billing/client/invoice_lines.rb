require 'billys_billing/model/invoice_line'
module BillysBilling
  class Client
    module InvoiceLines
      def invoice_lines
        get('invoice_lines')['invoice_lines'].map { |u| Model::InvoiceLine.new( u, client: self ) }
      end

      def invoice_line( id )
        invoice_line_data = get("invoice_lines/#{id}")['invoice_line']
        Model::InvoiceLine.new( invoice_line_data, client: self )
      end
    end
  end
end
