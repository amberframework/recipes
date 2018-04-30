require "spec"

def build_amber
  unless File.exists?("amber/bin/amber")
    system("rm -rf amber")
    system("git clone https://github.com/amberframework/amber.git")
    system("cd amber; make")
  end
end

def generate_app(recipe)
  system("amber/bin/amber new app -r `pwd`/#{recipe} --deps")
  system("cd app && ../amber/bin/amber g scaffold Category title:string")
  system("cd app && ../amber/bin/amber g scaffold Product title:string description:text category:reference")
  system("cd app && ../amber/bin/amber g scaffold Comment body:text product:reference")
end

def build_app
  system("cd app && shards build app")
end

def cleanup
  system("rm -rf app")
end
