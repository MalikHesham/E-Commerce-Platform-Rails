class SellersController < InheritedResources::Base

  private

    def seller_params
      params.require(:seller).permit(:name, :order_response)
    end

end
