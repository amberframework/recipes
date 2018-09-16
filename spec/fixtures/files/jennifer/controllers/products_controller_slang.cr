class ProductController < ApplicationController
  def index
    products = Product.all.to_a
    render("index.slang")
  end

  def show
    if product = Product.find(params["id"])
      render("show.slang")
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def new
    product = Product.build
    render("new.slang")
  end

  def create
    product = Product.build(product_params)
    if product.save
      flash["success"] = "Created Product successfully."
      redirect_to "/products"
    else
      flash["danger"] = "Could not create Product!"
      render("new.slang")
    end
  end

  def edit
    if product = Product.find(params["id"])
      render("edit.slang")
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def update
    if product = Product.find(params["id"])
      if product.update(product_params)
        flash["success"] = "Updated Product successfully."
        redirect_to "/products"
      else
        flash["danger"] = "Could not update Product!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def destroy
    if product = Product.find(params["id"])
      product.destroy
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
    end
    redirect_to "/products"
  end

  private def product_params
    validated_params =
      params.validation do
        required(:title) { |f| !f.nil? }
        required(:description) { |f| !f.nil? }
        required(:category_id) { |f| !f.nil? }
        required(:user_id) { |f| !f.nil? }
      end.validate!
    Product.build_params(validated_params)
  end
end
