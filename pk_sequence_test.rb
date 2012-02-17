require 'active_record'
module ActiveRecord
  class Base
    private
      def create
        if self.id.nil? && connection.prefetch_primary_key?(self.class.table_name)
          self.id = connection.next_sequence_value(self.class.sequence_name)
        end

        quoted_attributes = attributes_with_quotes

        statement = if quoted_attributes.empty?
          connection.empty_insert_statement(self.class.table_name)
        else
          "INSERT INTO #{self.class.quoted_table_name} " +
          "(#{quoted_column_names.join(', ')}) " +
          "VALUES(#{quoted_attributes.values.join(', ')})"
        end

        # The adapter is not correctly generating the SQL statement
        #statement = "#{statement} RETURNING id"

        #puts "Statement: #{statement}"
        #puts "Name: #{self.class.name} Create"
        #puts "Primary Key: #{self.class.primary_key}"
        #puts "Id: #{self.id}"
        #puts "Sequence: #{self.class.sequence_name}"

        self.id = connection.insert(statement, "#{self.class.name} Create",
          self.class.primary_key, self.id, self.class.sequence_name)


        @new_record = false
        id
      end
  end
end



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

puts "Creating some AR objects. Note the resource's id."
for x in 1..4 
  puts PkTest.create( :name=>"Item #{x}" ).inspect 
end
puts "-------------------------------------------------"
puts "Now reading them all back from the database. The resource id is correct."
PkTest.all.each do |i|
  puts i.inspect
end
