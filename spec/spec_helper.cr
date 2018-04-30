require "spec"

def build_amber
  unless File.exists?("./bin/amber")
    `shards install --production`
    system("shards build amber")
  end
end

def generate_app(recipe)
  `./bin/amber new app -r $(pwd)/#{recipe} -d sqlite --deps`
  system("cd app && ../bin/amber g scaffold Category title:string")
  system("cd app && ../bin/amber g scaffold Product title:string description:text category:reference")
  system("cd app && ../bin/amber g scaffold Comment body:text product:reference")
  system("cd app && ../bin/amber db migrate")
end

def build_app
  `cd app && shards install --production`
  system("cd app && shards build app")
end

def cleanup
  system("rm -rf app")
end
