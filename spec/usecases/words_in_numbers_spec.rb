require './app/entity/word_in_number'
require './app/entity/happy_numbers'
require './app/entity/sum'

RSpec.describe 'Words in numbers' do
  it 'should be prime number, happy and multiples of 3 and 5' do
    word = 'abcABC'

    alph_lowercase = ('a'..'z').to_a

    alph_uppercase = ('A'..'Z').to_a

    all_letters = alph_lowercase + alph_uppercase

    word_array = word.split('')

    sum_word = 0

    word_array.each do |item|
      sum_word += all_letters.index(item) + 1 if all_letters.index(item)
    end

    is_prime_number = Entity::WordInNumber.prime_number(sum_word)
    is_happy_number = Entity::HappyNumber.check_happy(sum_word)
    is_multiple = Entity::Sum.multiple_or?(sum_word, 3, 5)

    expect(is_prime_number).to be(false)
    expect(is_happy_number).to be(false)
    expect(is_multiple).to be(true)
  end
end
