require './app/entity/sum'

RSpec.describe Entity::Sum do
  context 'múltiplos de 3 ou 5 de números naturais abaixo de 1000' do
    it 'deve somar corretamente' do
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

  it 'soma de todos os números múltiplos de 3 e 5 de números naturais abaixo de 1000' do
    soma = 0

    expected_result = 33_165

    Entity::Sum.multiples.each do |item|
      soma = Entity::Sum.multiple_and(soma, item, 3, 5)
    end

    expect(soma).to eq(expected_result)
  end

  it 'soma de todos os números múltiplos de 3 e 5 de números naturais abaixo de 1000' do
    soma = 12

    soma = Entity::Sum.multiple_and(soma)

    expect(soma).to eq(12)
  end
end
