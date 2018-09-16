ENV["AMBER_ENV"] ||= "test"

require "spec"
require "garnet_spec"

require "../config/*"

# Automatically run migrations on the test database
Jennifer::Migration::Runner.migrate

# Disable query logger for tests
Jennifer::Config.logger = Logger.new nil

# Next lines will wrap each test case into a transaction. This assumes that
# there is only one db connection.
Spec.before_each do
  Jennifer::Adapter.adapter.begin_transaction
end

Spec.after_each do
  Jennifer::Adapter.adapter.rollback_transaction
end
