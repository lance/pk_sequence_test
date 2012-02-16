# Primary Key Bug

This script illustrates a bug that results in the primary key
for an ActiveRecord object not being set when run under JRuby.

# Running the Script

    $ rvm use jruby-1.6.5@pk_test --create
    $ gem install bundler
    $ bundle install
    $ bundle exec pk_sequence_test.rb

