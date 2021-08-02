require 'json'

module Entity
  module ExerciseFour
    class User
      def self.find(id = nil)
        users.find { |obj| obj['id'] == id }
      end

      def self.users
        file = File.read('./app/database/users.json')
        JSON.parse(file)
      end
    end
  end
end
