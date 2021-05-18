class CouponsController < InheritedResources::Base

  private

    def coupon_params
      params.require(:coupon).permit(:name)
    end

end
