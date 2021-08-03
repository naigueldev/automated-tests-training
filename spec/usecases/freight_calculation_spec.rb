# frozen_string_literal: true

require './app/entity/product'
require './app/entity/user'
require './app/entity/cart'
require './app/services/correios'
require './app/services/shipping_method'

RSpec.describe 'Freight calculation' do
  context 'less then 100' do
    it 'cart shipping total zero' do
      user_id = 4

      user = Entity::User.find(user_id)

      cart = Entity::Cart.new(user)

      cart_shipping = cart.calc_total

      expect(cart.get_items.count).to eq(0)

      expect(cart_shipping).to eq(0)
    end

    it 'cart shipping total less then 100' do
      product_one = Entity::Product.find(1)
      product_two = Entity::Product.find(2)
      product_three = Entity::Product.find(3)

      user_id = 4

      user = Entity::User.find(user_id)

      cart = Entity::Cart.new(user)

      cart.add(product_one, 2)
      cart.add(product_two, 2)
      cart.add(product_three, 2)

      cart_shipping = cart.calc_total

      allow(Services::Correios).to receive(:shipping_calculate)

      expect(cart.get_items.count).to eq(3)

      expect(cart_shipping).to eq(70)
    end

    it 'cart shipping total greater then 100' do
      product_one = Entity::Product.find(1)
      product_two = Entity::Product.find(2)
      product_three = Entity::Product.find(3)

      user_id = 4

      user = Entity::User.find(user_id)

      cart = Entity::Cart.new(user)

      cart.add(product_one, 3)
      cart.add(product_two, 3)
      cart.add(product_three, 3)

      cart_shipping = cart.calc_total

      allow(Services::Correios).to receive(:shipping_calculate)

      shipping_methods = Services::ShippingMethods.new(Services::Correios)

      calc_shipping = shipping_methods.calc_shipping(cart)

      expect(Services::Correios).to_not have_received(:shipping_calculate)

      expect(cart.get_items.count).to eq(3)

      expect(cart_shipping).to eq(105)
    end

    it 'cart shipping total less then 100, execute correios service' do
      product_one = Entity::Product.find(1)
      product_two = Entity::Product.find(2)
      product_three = Entity::Product.find(3)

      user_id = 4

      user = Entity::User.find(user_id)

      cart = Entity::Cart.new(user)

      cart.add(product_one, 2)
      cart.add(product_two, 2)
      cart.add(product_three, 2)

      cart_shipping = cart.calc_total

      allow(Services::Correios).to receive(:shipping_calculate).and_return(123_456)

      shipping_methods = Services::ShippingMethods.new(Services::Correios)

      calc_shipping = shipping_methods.calc_shipping(cart)

      expect(Services::Correios).to have_received(:shipping_calculate)

      expect(calc_shipping).to eq(123_456)

      expect(cart.get_items.count).to eq(3)

      expect(cart_shipping).to eq(70)
    end
  end
end
