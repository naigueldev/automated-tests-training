# frozen_string_literal: true

require './app/entity/product'
require './app/entity/user'
require './app/entity/cart'
require './app/services/correios'
require './app/services/shipping_method'

RSpec.describe 'Freight calculation' do
  context 'cart shipping greater then 100' do
    it 'should not execute service' do
      product_one = Entity::Product.find(1)
      product_two = Entity::Product.find(2)
      product_three = Entity::Product.find(3)

      user_id = 4

      user = Entity::User.find(user_id)

      cart = Entity::Cart.new(user)

      cart.add(product_one, 3)
      cart.add(product_two, 3)
      cart.add(product_three, 3)

      cart_total = cart.calc_total

      allow(Services::Correios).to receive(:shipping_calculate)

      shipping_methods = Services::ShippingMethods.new(Services::Correios)

      calc_shipping = shipping_methods.calc_shipping(cart)

      expect(Services::Correios).to_not have_received(:shipping_calculate)

      expect(cart.get_items.count).to eq(3)

      expect(cart_total).to eq(105)
      
      expect(calc_shipping).to eq(0)
    end
  end

  context 'cart shipping less then 100' do
    it 'should result zero when cart is empty' do
      user_id = 4

      user = Entity::User.find(user_id)

      cart = Entity::Cart.new(user)

      cart_shipping = cart.calc_total

      expect(cart.get_items.count).to eq(0)

      expect(cart_shipping).to eq(0)
    end

    it 'should calculate of cart total' do
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

      expect(cart.get_items.count).to eq(3)

      expect(cart_shipping).to eq(70)
    end

    it 'should calc shipping and execute service method once' do
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

  context 'add same product to existing cart' do
    it 'should increase the product quantity' do
      product = Entity::Product.find(1)

      user = Entity::User.find(1)

      cart = Entity::Cart.new(user)

      cart.add(product, 1)
      cart.add(product, 1)

      cart_shipping = cart.calc_total

      expect(cart.get_items.count).to eq(1)

      expect(cart_shipping).to eq(40)
    end
  end

  context 'remove product from cart' do
    it 'should remove product' do
      product = Entity::Product.find(1)

      user = Entity::User.find(1)

      cart = Entity::Cart.new(user)

      cart.add(product, 1)
      
      cart.remove_product(product)
      
      cart_shipping = cart.calc_total

      expect(cart.get_items.count).to eq(0)

      expect(cart_shipping).to eq(0)
    end
  end
  
  context 'reset product quantity from cart' do
    it 'should remove product from cart' do
      product = Entity::Product.find(1)
      product_two = Entity::Product.find(2)

      user = Entity::User.find(1)

      cart = Entity::Cart.new(user)

      cart.add(product, 1)
      cart.add(product_two, 3)
      
      cart.update(product, 0)
      
      cart_shipping = cart.calc_total

      expect(cart.get_items.count).to eq(1)

      expect(cart_shipping).to eq(30)
    end
  end
end
