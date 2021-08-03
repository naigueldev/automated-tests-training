# frozen_string_literal: true

require './app/entity/sum'

RSpec.describe Entity::Sum do
  context 'multiples of 3 or 5, less then 1000' do
    it 'should be the correct result' do
      soma = 0

      expected_result = 233_168

      Entity::Sum.multiples.each do |item|
        soma = Entity::Sum.multiple_or(soma, item, 3, 5)
      end

      expect(soma).to eq(expected_result)
    end

    it 'should be incorrect result' do
      soma = 0

      expected_result = 233_168

      Entity::Sum.multiples.each do |item|
        soma = Entity::Sum.multiple_or(soma, item, 3, 7)
      end

      expect(soma).to_not eq(expected_result)
    end
  end

  context 'multiples of 3 and 5, less then 1000' do
    it 'should be the correct result' do
      soma = 0

      expected_result = 33_165

      Entity::Sum.multiples.each do |item|
        soma = Entity::Sum.multiple_and(soma, item, 3, 5)
      end

      expect(soma).to eq(expected_result)
    end
  end
end
