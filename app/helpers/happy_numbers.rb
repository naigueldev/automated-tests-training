# frozen_string_literal: true

module Helper
  class HappyNumber
    def self.check_happy(number = 0, ready_pass = [])
      array_numbers = number.digits

      square_sum = 0

      array_numbers.each do |number|
        square_sum += number**2
      end

      return false if ready_pass.include?(square_sum)

      return true if square_sum == 1

      ready_pass << square_sum

      Helper::HappyNumber.check_happy(square_sum, ready_pass)
    end
  end
end
