class CartsController < ApplicationController



  def show
    @cart_items =current_user.cart.product_adapters
  end

  def add
    @cart=current_user.cart
    @cart_item =@cart.purchasable.find_by(item_params)
    if @cart_item.present?
      @cart_item.quantity += 1
    else
      @cart_item =@cart.purchasable.new(item_params)
    end
    @cart_item.save
  end

  private

  def item_params
    params.require(:product).permit(:product_id)
  end




end
