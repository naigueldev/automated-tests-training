# frozen_string_literal: true

require 'prime'

module Helper
  class WordInNumber
    def self.prime_number(number = 0)
      Prime.prime?(number)
    end
  end
end
