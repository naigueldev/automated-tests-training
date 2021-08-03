# frozen_string_literal: true

require 'json'

module Entity
  class Cart
    attr_reader :user

    def initialize(user)
      @user = user
      @items = []
    end

    def add(product, quantity)
      return increase_quantity(product, quantity) if product_present?(product)

      item = {
        user: @user,
        product: product,
        quantity: quantity
      }

      @items << item
    end

    def update(product, quantity)
      update_quantity(product, quantity) if product_present?(product)
    end

    def remove_product(product)
      @items.each { |item| 
        @items.delete(item) if item[:product] == product 
      }
    end

    def update_quantity(product, quantity)
      @items.each { |item| 
        item[:quantity] = quantity if item[:product] == product 
        @items.delete(item) if quantity.zero?
      }
    end

    def increase_quantity(product, quantity)
      @items.each { |item| 
        item[:quantity] += quantity if item[:product] == product 
      }
    end

    def product_present?(product)
      @items.any? { |item| item[:product] == product }
    end

    def calc_total
      cart_items = find_user_items

      item_sum = 0

      cart_items.each do |item|
        item_sum += item[:quantity] * item[:product]['price']
      end

      item_sum
    end

    def find_user_items
      @items.select { |obj| obj[:user] == @user }
    end

    def get_items
      @items
    end
  end
end
