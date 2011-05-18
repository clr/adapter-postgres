# before attempting to 'require' this script into console, make sure
# you have 'adapter' in your Gemfile, and make sure you have the
# HSTORE data type available in your postgresql database.  If you
# have permission and 'contribs' for postgres, you can add HSTORE
# with something like:
# psql database_name < /usr/share/pgsql/contrib/hstore.sql
# a copy of hstore.sql is kept in this examples directory as well.

require 'rubygems'
require 'pathname'

root_path = Pathname(__FILE__).dirname.join('..').expand_path
lib_path  = root_path.join('lib')
$:.unshift(lib_path)

require 'adapter/postgres'

# say we are working inside of an existing Rails application
client = ActiveRecord::Base.connection.instance_variable_get("@connection")

# check and see if our table exists yet
table = client.exec("SELECT COUNT(relname) FROM pg_class WHERE relname='generic_hstore_table'").getvalue(0,0)
if table == 0
  # then create the table we want and seed it
  client.exec("CREATE TABLE generic_hstore_table (data hstore)")
  client.exec("INSERT INTO generic_hstore_table VALUES (''::hstore)")
end

# start the adapter
adapter = Adapter[:postgres].new(client)
adapter.clear

adapter['foo'] = 'bar'
puts 'Should be bar: ' + adapter['foo'].inspect

adapter.delete('foo')
puts 'Should be nil: ' + adapter['foo'].inspect

adapter['foo'] = 'bar'
adapter.clear
puts 'Should be nil: ' + adapter['foo'].inspect

puts 'Should be bar: ' + adapter.fetch('foo', 'bar')
