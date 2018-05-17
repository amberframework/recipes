require "./recipes_spec"

describe "Default" do
  it "compiles and tests default recipe" do
    generate_app recipe: "default"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
