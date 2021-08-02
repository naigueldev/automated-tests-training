module Entity
    class HappyNumber
        def self.check_happy(number = 0, ready_pass = [])
            array_numbers = number.digits

            square_sum = 0

            array_numbers.each { |number|
                square_sum += number ** 2
            }

            return false if ready_pass.include?(square_sum)

            return true if square_sum == 1

            ready_pass << square_sum

            Entity::HappyNumber.check_happy(square_sum, ready_pass)
        end
    end
end