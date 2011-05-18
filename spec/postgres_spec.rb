require 'helper'
require 'adapter/postgres'

describe "Postgres adapter" do
  include PgTestingHelper

  before(:all) do
    @conn = setup_testing_db( "adapterpsql" )

    # add HSTORE compatibility
    File.open(File.join(File.dirname(__FILE__),'..','examples','hstore.sql'),'r'){|f| @conn.exec(f.read)}

    # this creates the table we want
    @conn.exec("CREATE TABLE generic_hstore_table (data hstore)")
    @conn.exec("INSERT INTO generic_hstore_table VALUES (''::hstore)")

    @adapter = Adapter[:postgres].new(@conn)
  end

  before(:each) do
    @adapter.clear
  end

  let(:adapter) { @adapter }
  let(:client)  { @conn }

  it_should_behave_like 'a marshaled adapter'
end
