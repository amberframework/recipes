require "./recipes_spec"

describe "React Preact-Redux" do
  it "compiles and tests react/preact_redux recipe with slang and granite" do
    generate_app(recipe: "react/preact_redux").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests react/preact_redux recipe with ecr and granite" do
    generate_app(recipe: "react/preact_redux", template: "ecr").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests react/preact_redux recipe with slang and crecto" do
    generate_app(recipe: "react/preact_redux", template: "slang", model: "crecto").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests react/preact_redux recipe with ecr and crecto" do
    generate_app(recipe: "react/preact_redux", template: "ecr", model: "crecto").should be_true
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
