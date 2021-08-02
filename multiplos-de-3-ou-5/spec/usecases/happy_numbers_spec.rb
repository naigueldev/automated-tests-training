require './app/entity/happy_numbers'

RSpec.describe 'Happy Numbers' do
  it 'should be happy' do
    happy_numbers = [1, 7, 10, 13, 19, 23, 28]

    happy_numbers.each do |number|
      result = Entity::HappyNumber.check_happy(number)

      happy = true

      puts "Number #{number} is happy"

      expect(result).to eq(happy)
    end
  end

  it 'should not be happy' do
    unhappy_numbers = [2, 4, 6, 8, 90]

    unhappy_numbers.each do |number|
      result = Entity::HappyNumber.check_happy(number)

      happy = false

      puts "Number #{number} is not happy"

      expect(result).to eq(happy)
    end
  end
end
