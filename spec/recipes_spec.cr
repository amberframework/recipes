require "./spec_helper"

build_amber

describe "Compile available recipes" do
  it "compiles and tests default recipe" do
    generate_app recipe: "default"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests basic/granite recipe" do
    generate_app recipe: "basic/granite"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  # TODO: crecto scaffolding is broken
  # the crecto builtin template is also broken
  # it "compiles and tests basic/crecto recipe" do
  #   generate_app recipe: "basic/crecto"
  #   build_app.should be_true
  # ensure
  #   cleanup
  # end

  it "compiles and tests misc/modular recipe" do
    generate_app recipe: "misc/modular"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

  it "compiles and tests react/preact_redux recipe" do
    generate_app recipe: "misc/modular"
    build_app.should be_true
    test_app.should be_true
  ensure
    cleanup
  end

end
