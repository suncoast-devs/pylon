ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'minitest/spec'

module ActiveSupport
  class TestCase
    fixtures :all

    def user(admin:)
      given_name = admin ? "Anne" : "Ursula"
      family_name = admin ? "Admin" : "User"

      User.create(person: Person.create(given_name: given_name, family_name: family_name), is_admin: admin, auth_sub: "")
    end

    def admin_user
      user(admin: true)
    end

    def non_admin_user
      user(admin: false)
    end

    def admin_query(query:)
      query(user: admin_user, query: query)
    end

    def user_query(query:)
      query(user: non_admin_user, query: query)
    end

    def query(user:, query:)
      post "/", params: {
        user_id: user.id,
        query: query
      }
    end

    def result
      @result ||= {}
      @result[@response.body] ||= ActiveSupport::JSON.decode(@response.body)
    end

    def data
      result["data"]
    end

  end
end
