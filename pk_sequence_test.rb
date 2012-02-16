require 'active_record'

ActiveRecord::Base.logger = Logger.new('debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('database.yml'))
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
