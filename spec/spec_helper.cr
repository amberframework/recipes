require "spec"

def build_amber
  unless File.exists?("amber/bin/amber")
    system("rm -rf amber")
    system("git clone https://github.com/amberframework/amber.git")
    system("cd amber; make")
  end
end

def generate_app(recipe)
  system("amber/bin/amber new app -r #{recipe} --deps")
end

def build_app
  system("cd app && shards build app")
end

def cleanup
  system("rm -rf app")
end
