require "./recipes_spec"

describe "Misc Modular" do
  it "compiles and tests misc/modular recipe with slang template" do
    generate_app(recipe: "misc/modular", template: "slang").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests misc/modular recipe with ecr template" do
    generate_app(recipe: "misc/modular", template: "ecr").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests misc/modular recipe with slang template and crecto model" do
    generate_app(recipe: "misc/modular", template: "slang", model: "crecto").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests misc/modular recipe with ecr template and crecto model" do
    generate_app(recipe: "misc/modular", template: "ecr", model: "crecto").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
