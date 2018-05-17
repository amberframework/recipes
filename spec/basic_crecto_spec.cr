require "./recipes_spec"

describe "Basic Crecto" do
  it "compiles and tests basic/crecto recipe" do
    generate_app recipe: "basic/crecto"
    build_app.should be_true
  ensure
    cleanup
  end
end
