require "./recipes_spec"

describe "Basic Granite" do
  it "compiles and tests basic/granite recipe" do
    generate_app recipe: "basic/granite"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
