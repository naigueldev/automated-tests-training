require './app/entity/exercise_four/product'
require './app/entity/exercise_four/user'
require './app/entity/exercise_four/cart'

RSpec.describe 'Freight calculation' do
    context 'less then 100' do

        it 'cart shipping total zero' do
            user_id = 4
        
            user = Entity::ExerciseFour::User.find(user_id)
            
            cart_shipping = Entity::ExerciseFour::Cart.calc_shipping(user)
        
            expect(Entity::ExerciseFour::Cart.items.count).to eq(0)
            
            expect(cart_shipping).to eq(0)
        end

        it 'cart shipping total' do
          # TODO: mock find freight calculation method by user.cep
          # TODO: spy on freight calculation method
      
          product_one = Entity::ExerciseFour::Product.find(1)
          product_two = Entity::ExerciseFour::Product.find(2)
          product_three = Entity::ExerciseFour::Product.find(3)
      
          user_id = 4
      
          user = Entity::ExerciseFour::User.find(user_id)
          
          Entity::ExerciseFour::Cart.add(user, product_one, 2)
          Entity::ExerciseFour::Cart.add(user, product_two, 2)
          Entity::ExerciseFour::Cart.add(user, product_three, 2)
      
          cart_shipping = Entity::ExerciseFour::Cart.calc_shipping(user)
      
          # TODO: expect freight calculation method called once
      
          expect(Entity::ExerciseFour::Cart.items.count).to eq(3)
          
          expect(cart_shipping).to eq(70)
        end
    end
end
