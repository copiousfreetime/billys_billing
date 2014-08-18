#!/usr/bin/env ruby

require 'harvested'
require 'billys_billing'

harvest_username  = ENV['HARVEST_USERNAME']
harvest_password  = ENV['HARVEST_PASSWORD']
harvest_subdomain = ENV['HARVEST_SUBDOMAIN']

REVENUE_ACCOUNT = 'Consulting'

harvest = Harvest.hardy_client(harvest_subdomain, harvest_username, harvest_password)
billy   = BillysBilling.client

def migrate_contacts( harvest, billy )
  puts "Create new Contacts in Billy's Billing to match the Clients and People in Harvest"
  harvest.clients.all.each do |client|
    existing = billy.find_contacts( client.name )
    bcontact = existing.first
    if bcontact.nil? then
      bcontact = BillysBilling::Model::Contact.new( client: billy )
      bcontact.type        = 'company'
      bcontact.name        = client.name
      bcontact.street      = client.details
      bcontact.country_id  = 'US'
      bcontact.is_customer = true
    #  bcontact.is_archived = !client.active
      bcontact = bcontact.save
      print "Created: "
    end
    puts "#{bcontact.name}"
    harvest.contacts.all( client.id ).each do |contact|
      existing = bcontact.find_persons( contact.email )
      person   = existing.first

      if person.nil? then
        person            = BillysBilling::Model::ContactPerson.new( client: billy )
        person.name       = "#{contact.first_name} #{contact.last_name}"
        person.contact_id = bcontact['id']
        person.email      = contact.email
        person            = person.save
        print "  Created: "
      end

      puts "  #{person.name} #{person.email}"
    end
  end
end

def migrate_projects( harvest, billy )
  puts "Create new Products in Billy's Billing to match the Projects in Harvest."
  consulting_account = billy.find_accounts( REVENUE_ACCOUNT ).first
  puts "New Products will have a default revenue account of #{consulting_account.name}"
  harvest.projects.all.each do |project|
    puts "Converting #{project.name}"
    existing = billy.find_products( project.code )
    if not existing.empty? then
      puts "  Already exists #{existing.first.name}"
      next
    end

    product = BillysBilling::Model::Product.new( client: billy )
    product.organization_id = billy.organization.id
    product.name            = project.name
    product.description     = "Hours worked on #{project.name}"
    product.account_id      = consulting_account.id
    product.product_no      = project.code
    product = product.save

    price = BillysBilling::Model::ProductPrice.new( client: billy )
    price.product_id  = product['id']
    price.currency_id = 'USD'
    price.unit_price  = project.hourly_rate
    price = price.save
    puts "  Created #{product.id} @ #{price.unit_price}"
  end
end

def migrate_invoices( harvest, billy )
  puts "Create New Invoices in Billy's Billing to match the Invoices in Harvest."

  org              = billy.organization
  billy_contacts   = billy.contacts.each_with_object( {} )      { |c,h| h[c.name]       = c }
  billy_invoices   = billy.invoices.each_with_object( {} )      { |i,h| h[i.invoice_no] = i }
  billy_products   = billy.products.each_with_object( {} )      { |p,h| h[p.product_no] = p }
  harvest_projects = harvest.projects.all.each_with_object( {} ){ |p,h| h[p.id.to_s]    = p }

  harvest.invoices.all.each do |invoice|
    next unless invoice.issued_at >= '2013-01-01'
    binvoice = billy_invoices[ invoice.number ]

    puts "Creating invoice No. #{invoice.number} for client #{invoice.client_name}"
    bcontact = billy_contacts[ invoice.client_name ]

    if binvoice.nil? then
      hinvoice = harvest.invoices.find( invoice.id )

      binvoice                 = BillysBilling::Model::Invoice.new( client: billy )
      binvoice.organization_id = org.id
      binvoice.type            = 'invoice'
      binvoice.contact_id      = bcontact.fetch('id')
      binvoice.entry_date      = invoice.issued_at
      binvoice.due_date        = invoice.due_at
      binvoice.invoice_no      = invoice.number
      binvoice.state           = 'approved'
      binvoice.sent_state      = 'sent'
      binvoice.lines           = []

      harvest_project_id = nil

      hinvoice.line_items.each do |line_item|

        # Assume the first time through there is a valid one.
        harvest_project_id = line_item.project_id || harvest_project_id
        h_project          = harvest_projects.fetch( harvest_project_id )
        b_product          = billy_products.fetch( h_project.code )

        bline = BillysBilling::Model::InvoiceLine.new( client: billy )
        default_product_id = default_product_id || b_product.fetch('id')
        bline.product_id  = b_product.fetch('id', default_product_id)
        bline.quantity    = line_item.quantity
        bline.unit_price  = line_item.unit_price
        bline.description = line_item.description
        binvoice.lines << bline
      end

      binvoice = binvoice.save
      print "  Created"
    else
      print "  Existing"
    end
    puts "  Invoice #{binvoice.invoice_no}"
  end

end

def check_invoices( harvest, billy )
  billy_invoices   = billy.invoices.each_with_object( {} )      { |i,h| h[i.invoice_no] = i }

  harvest.invoices.all.each do |hinvoice|
    next unless hinvoice.issued_at >= '2013-01-01'
    binvoice = billy_invoices[ hinvoice.number ]
    abort "Missing invoice #{invoice.number} in billy" unless binvoice

    if binvoice.amount != hinvoice.amount then
      abort "Invoice #{binvoice.invoice_no} has amout of #{binvoice.amount} and harvest has #{hinvoice.amount}"
    else
      puts "Harvest Invoice #{hinvoice.number} -> #{hinvoice.amount}"
      puts " Billy  Invoice #{binvoice.invoice_no} -> #{binvoice.amount}"
    end
  end
end

if $0 == __FILE__ then
#  migrate_contacts( harvest, billy )
#  migrate_projects( harvest, billy )
#  migrate_invoices( harvest, billy )

  check_invoices( harvest, billy )
end

