require "./recipes_spec"

describe "Basic Crecto" do
  it "compiles and tests basic/crecto recipe with slang templates" do
    generate_app(recipe: "basic/crecto", template: "slang").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests basic/crecto recipe with ecr templates" do
    generate_app(recipe: "basic/crecto", template: "ecr").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
