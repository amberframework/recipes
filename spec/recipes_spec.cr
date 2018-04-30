require "./spec_helper"

build_amber

describe "Compile available recipes" do
  it "compiles default recipe" do
    generate_app recipe: "default"
    build_app.should be_true
  ensure
    cleanup
  end

  it "compiles basic/granite recipe" do
    generate_app recipe: "basic/granite"
    build_app.should be_true
  ensure
    cleanup
  end

  # TODO: crecto scaffolding is broken
  # it "compiles basic/crecto recipe" do
  #   generate_app recipe: "basic/crecto"
  #   build_app.should be_true
  # ensure
  #   cleanup
  # end

  # TODO: Looks like modular recipe is broken 
  # it "compiles misc/modular recipe" do
  #   generate_app recipe: "misc/modular"
  #   build_app.should be_true
  # ensure
  #   cleanup
  # end
end
