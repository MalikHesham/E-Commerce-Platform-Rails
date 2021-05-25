class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
    @items = current_user == @order.user ? @order.product_adapter : @order.current_store_orders(current_user)
    @accepted_count = get_order_confirmed_count(@order)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit

  end

  # POST /orders or /orders.json
  def create
    cart = current_user.cart
    total = cart.calculate_total
    order = Order.create({ :user_id => current_user.id })
    cart.product_adapters.map { |item| item.purchasable = order; item.item_price = item.product.price; item.save; order.store << item.product.store }
    order.total = total
    order.save
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    if !update_order_params.slice(:mark_delivered).empty?
      @order.status = 2
      @order.save
    else
      @order.current_store_orders(current_user).update({ :confirmed => true })
      if get_order_confirmed_count(@order) == @order.product_adapter.size
        @order.status = 1
        @order.save
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:User_id, :total)
  end

  def update_order_params
    params.permit(:mark_delivered)
  end

  def get_order_confirmed_count(order)
    order.product_adapter.pluck(:confirmed).count { |value| value == true }
  end
end
