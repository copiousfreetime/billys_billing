require 'spec_helper'
require 'billys_billing'

describe BillysBlling::VERSION do
  it 'should have a #.#.# format' do
    BillysBlling::VERSION.must_match( /\A\d+\.\d+\.\d+\Z/ )
    BillysBlling::VERSION.to_s.must_match( /\A\d+\.\d+\.\d+\Z/ )
  end
end
