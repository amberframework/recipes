require "./recipes_spec"

describe "Default" do
  it "compiles and tests default recipe with slang template and granite model" do
    generate_app(recipe: "default", template: "slang").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests default recipe with ecr template and granite model" do
    generate_app(recipe: "default", template: "ecr").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests default recipe with slang template and crecto model" do
    generate_app(recipe: "default", template: "slang", model: "crecto").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests default recipe with ecr template and crecto model" do
    generate_app(recipe: "default", template: "ecr", model: "crecto").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
