class CartsController < ApplicationController



  def show
    @cart =current_user.cart
  end

  def add
    @cart=current_user.cart
    @cart_item =@cart.product_adapters.find_by(item_params)
    if @cart_item.present?
      @cart_item.product_quantity += 1
    else
      @cart_item =@cart.product_adapters.new(item_params)
      @cart_item.product_quantity =1
    end
    @cart_item.save

  end

  private
  def item_params
    params.permit(:product_id)
  end

end
