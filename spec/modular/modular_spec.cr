require "./recipes_spec"

describe "Misc Modular" do
  it "compiles and tests misc/modular recipe" do
    generate_app recipe: "misc/modular"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
