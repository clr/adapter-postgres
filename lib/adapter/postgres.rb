require 'adapter'
require 'pg'

module Adapter
  module Postgres
    def table_name
      "generic_hstore_table"
    end

    # I don't think this is ever used?
    def key?(key)
      res = client.exec("SELECT exist(data,'#{key_for(key)}') AS v FROM #{table_name}")
      res.getvalue(0,0) != "f"
    end

    def read(key)
      res = client.exec("SELECT data -> '#{key_for(key)}' AS v FROM #{table_name}")
      decode(res.getvalue(0,0))
    end

    def write(key, value)
      res = client.exec("UPDATE #{table_name} SET data = data || hstore('#{key_for(key)}','#{encode(value)}')")
      value
    end

    def delete(key)
      if value = read(key)
        res = client.exec("UPDATE #{table_name} SET data = delete(data,'#{key_for(key)}')")
      end
      value
    end

    def clear
      res = client.exec("UPDATE #{table_name} SET data = ''::hstore")
    end
  end
end

Adapter.define(:postgres, Adapter::Postgres)
