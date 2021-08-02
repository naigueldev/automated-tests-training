module Entity
  class Sum
    def self.multiples(start_number = 0, end_number = 1000)
      (start_number...end_number).to_a
    end

    def self.multiple_or(sum_number = 0, item = 0, number_one = 3, number_two = 5)
      sum_number += item if (item % number_one).zero? || (item % number_two).zero?
      sum_number
    end

    def self.multiple_or?(item = 0, number_one = 3, number_two = 5)
      (item % number_one).zero? || (item % number_two).zero?
    end

    def self.multiple_and(sum_number = 0, item = 0, number_one = 3, number_two = 5)
      sum_number += item if item % number_one == 0 && item % number_two == 0
      sum_number
    end

    def self.multiple_or_and(sum_number = 0, item = 0, number_one = 3, number_two = 5, number_three = 7)
      sum_number += item if ((item % number_one == 0) || (item % number_two == 0)) && item % number_three == 0
      sum_number
    end
  end
end
