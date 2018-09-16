require "./config/*"
require "sam"
require "./db/migrations/*"

load_dependencies "jennifer"

# This will hide all query related log information beneath INFO level
Jennifer::Config.configure do |conf|
  conf.logger.level = Logger::INFO
end
#
# This is a Sam file. Place your tasks here or in separate files and load them
# explicitly. To load any package defined Sam task - use:
#
# load_dependencies "package_name"
#
# Here is an example of simple Sam task:
#
# Sam.namespace "simon" do
#   task "says" do |t, args|
#     puts args[0]
#   end
# end
#
# To invoke this task use:
# $ crystal sam.cr -- simon:says "Get happy codding with Amber"
#
# For the following reading visit the https://github.com/imdrasil/sam.cr.
#

Sam.help
