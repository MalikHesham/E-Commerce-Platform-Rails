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


  def update
    @cart=current_user.cart
    @cart_item =@cart.product_adapters.where(:product_id => update_item_params[:product_id]).first
    @cart_item.update_attributes(update_item_params)
  end

  def destroy
    @cart=current_user.cart
    @cart_item =@cart.product_adapters.where(:product_id => params[:product_id]).first
    @cart_item.destroy

    redirect_to carts_url
  end

  def empty
    @cart=current_user.cart
  end

  private
  def item_params
    params.permit(:product_id)
  end
  def update_item_params
    params.permit(:product_id, :product_quantity)
  end

end