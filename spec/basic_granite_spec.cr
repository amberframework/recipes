require "./recipes_spec"

describe "Basic Granite" do
  it "compiles and tests basic/granite recipe with slang template" do
    generate_app(recipe: "basic/granite", template: "slang").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests basic/granite recipe with ecr template" do
    generate_app(recipe: "basic/granite", template: "ecr").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
