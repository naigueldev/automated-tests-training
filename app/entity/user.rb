# frozen_string_literal: true

require 'json'

module Entity
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
