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
      new_cart = {
        user: @user,
        product: product,
        quantity: quantity
      }

      @items << new_cart
    end

    def calc_total
      cart_items = @items.select { |obj| obj[:user] == @user }

      item_sum = 0

      cart_items.each do |item|
        item_sum += item[:quantity] * item[:product]['price']
      end

      item_sum
    end

    def get_items
      @items
    end
  end
end
