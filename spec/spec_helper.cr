require "spec"

def build_amber
  unless File.exists?("./bin/amber")
    system("shards build amber --production")
  end
end

def generate_app(recipe)
  system("./bin/amber new app -r `pwd`/#{recipe} --deps")
  system("cd app && ../bin/amber g scaffold Category title:string")
  system("cd app && ../bin/amber g scaffold Product title:string description:text category:reference")
  system("cd app && ../bin/amber g scaffold Comment body:text product:reference")
end

def build_app
  system("cd app && shards build app")
end

def cleanup
  system("rm -rf app")
end
