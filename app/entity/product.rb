# frozen_string_literal: true

require 'json'

module Entity
  class Product
    def self.find(id = nil)
      products.find { |obj| obj['id'] == id }
    end

    def self.products
      file = File.read('./app/database/products.json')
      JSON.parse(file)
    end
  end
end
