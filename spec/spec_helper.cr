require "spec"

def build_amber
  unless File.exists?("./bin/amber")
    system("shards install --production")
    system("shards build amber")
  end
end

def generate_app(recipe, template = "slang", model = "granite")
  system("./bin/amber new app -r $(pwd)/#{recipe} -d sqlite -t #{template} -m #{model}")
  system("cd app && ../bin/amber g controller Information all")

  # TODO: uncomment after https://github.com/amberframework/amber/pull/818 is merged
  # system("cd app && ../bin/amber g model Data title:string body:text")

  # FIXME: see https://github.com/amberframework/amber/pull/815
  if model == "granite"
    system("cd app && ../bin/amber g auth User")
  else
    system("cd app && ../bin/amber g model User email:string")
  end

  system("cd app && ../bin/amber g scaffold Category title:string")
  system("cd app && ../bin/amber g scaffold Product title:string description:text category:reference")
  system("cd app && ../bin/amber g scaffold Comment body:text product:reference")
  system("cd app && ../bin/amber db migrate")

  # TODO: see https://github.com/amberframework/recipes/pull/15
  # system("cd app && crystal tool format src config spec --check")
end

def build_app
  system("cd app && shards build app")
end

def test_app
  system("cd app && crystal spec")
end

def cleanup
  system("rm -rf app")
end
