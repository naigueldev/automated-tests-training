# frozen_string_literal: true

module Services
  class ShippingMethods
    def initialize(shipping_calc_service = nil)
      @shipping_calc_service = shipping_calc_service
      @min_shipping_value = 100
      @default_shipping = 0
    end

    def calc_shipping(cart)
      user_zip_code = cart.user['zip_code']
      cart_total = cart.calc_total

      return @shipping_calc_service.shipping_calculate(user_zip_code) if cart_total < @min_shipping_value

      @default_shipping
    end
  end
end
