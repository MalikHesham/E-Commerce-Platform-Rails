class SellersController < InheritedResources::Base

  private

    def seller_params
      params.require(:seller).permit(:name, :order_response)
    end

    def accept

      params.require(:seller).permit(id => seller_id)
    end

end
