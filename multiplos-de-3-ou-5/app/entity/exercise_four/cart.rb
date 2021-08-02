require 'json'

module Entity
  module ExerciseFour
    class Cart
      @items = []

      def self.add(user, product, quantity)
        new_cart = {
          user: user,
          product: product,
          quantity: quantity
        }
        
        items << new_cart
      end

      def self.calc_shipping(user)
        cart_items = items.select { |obj| obj[:user] == user }
        
        item_sum = 0

        cart_items.each { |item| 
          item_sum += item[:quantity] * item[:product]['price']
        }

        item_sum
      end

      def self.items
        @items
      end

    end
  end
end
