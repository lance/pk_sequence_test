require 'active_record'

DB_CONFIG =  {
     'development' => {
        'adapter'  => 'postgresql',
        'database' => 'testapp',
        'username' => 'testapp',
        'password' => 'testapp',
        'host'     => 'localhost',
        'encoding' => 'UTF8'
     }
  }

ActiveRecord::Base.logger = Logger.new('debug.log')
ActiveRecord::Base.configurations = DB_CONFIG
ActiveRecord::Base.establish_connection('development')

ActiveRecord::Schema.define :version => 0 do
   create_table :pk_tests, :force => true do |t|
     t.string :name
   end
end

class PkTest < ActiveRecord::Base ; end

for x in 1..4 
  puts PkTest.create( :name=>"Item #{x}" ).inspect 
end
