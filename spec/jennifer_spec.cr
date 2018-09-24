require "./recipes_spec"

module JenniferHelpers
  class JenniferSpecRunner
    DEFAULT_APP_NAME = "app"

    def setup_application(name = DEFAULT_APP_NAME, template = "slang")
      system("./bin/amber new #{name} -r $(pwd)/jennifer -d pg -t #{template} -m jennifer")
      system("cd #{name} && ../bin/amber g controller Information all")
      system("cd #{name} && ../bin/amber g model Data title:string body:text")
      # TODO: uncomment after recipe begin supporting of auth templates
      # system("cd #{name} && ../bin/amber g auth User")
      system("cd #{name} && ../bin/amber g scaffold Category title:string user_id")
      system("cd #{name} && ../bin/amber g scaffold Product title:string description:text category:reference user_id")
      system("cd #{name} && ../bin/amber g scaffold Comment body:text product:reference user_id")
      system("cd #{name} && shards install")

      system("cd #{name} && AMBER_ENV=test crystal sam.cr -- db:setup")
    end

    def cleanup(name = DEFAULT_APP_NAME)
      system("cd #{name} && AMBER_ENV=test crystal sam.cr -- db:drop")
      system("rm -rf app")
    end

    def formatting_status(name = DEFAULT_APP_NAME)
      system("cd #{name} && crystal tool format src config spec db/migrations --check")
    end

    def file(path, app = DEFAULT_APP_NAME)
      File.read(File.join(app, path))
    end

    def fixtures(path)
      File.read(File.join("spec", "fixtures", "files", path))
    end
  end

  @@runner = JenniferSpecRunner.new

  def self.runner
    @@runner
  end
end

runner = JenniferHelpers.runner

describe "Jennifer" do
  it "compiles and tests jennifer recipe with Slang templates" do
    runner.setup_application(template: "slang")
    runner.formatting_status.should be_true
    build_app.should be_true

    runner.file("src/models/product.cr").should eq(runner.fixtures("jennifer/models/product.cr"))
    runner.file("src/controllers/product_controller.cr").should eq(runner.fixtures("jennifer/controllers/products_controller_slang.cr"))

    test_app.should be_true
  ensure
    runner.cleanup
  end

  it "compiles and tests jennifer recipe with ECR templates" do
    runner.setup_application(template: "ecr")
    runner.formatting_status.should be_true
    build_app.should be_true

    runner.file("src/models/product.cr").should eq(runner.fixtures("jennifer/models/product.cr"))
    runner.file("src/controllers/product_controller.cr").should eq(runner.fixtures("jennifer/controllers/products_controller_ecr.cr"))

    test_app.should be_true
  ensure
    runner.cleanup
  end
end
