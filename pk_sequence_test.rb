require 'active_record'

ActiveRecord::Base.logger = Logger.new('debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('database.yml'))
ActiveRecord::Base.establish_connection('development')

require 'db/schema'

class PkTest < ActiveRecord::Base
end

p = PkTest.create(:name => 'foo')
puts p.inspect
p = PkTest.create(:name => 'bar')
puts p.inspect
p = PkTest.create(:name => 'foobar')
puts p.inspect
p = PkTest.create(:name => 'barfoo')
puts p.inspect
