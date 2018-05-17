require "./recipes_spec"

describe "React Preact-Redux" do
  it "compiles and tests react/preact_redux recipe" do
    generate_app recipe: "react/preact_redux"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end
end
