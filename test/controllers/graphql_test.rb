require 'test_helper'

class GraphqlTest < ActionDispatch::IntegrationTest
  test "Users can see their own profile" do
    user_query query: <<-QUERY
      {
        me {
          fullName
          givenName
        }
      }
    QUERY

    refute result["errors"]
    assert data["me"]["fullName"]
    assert data["me"]["givenName"]
  end

  test "Users cannot see invitations" do
    user_query query: <<-QUERY
      {
        invitations {
          name
        }
      }
    QUERY

    assert result["errors"]
  end

  test "Users can see cohorts" do
    10.times { |i| Cohort.create!(name: "Cohort #{i}") }

    user_query query: <<-QUERY
      {
        cohorts {
          name
          description
        }
      }
    QUERY

    assert_equal 10, data["cohorts"].size
  end

  test "Admins can see invitations" do
    admin_query query: <<-QUERY
      {
        invitations {
          name
        }
      }
    QUERY

    refute result["errors"]
    assert data["invitations"]
  end

  test "Admins can see cohorts" do
    10.times { |i| Cohort.create!(name: "Cohort #{i}") }

    admin_query query: <<-QUERY
      {
        cohorts {
          name
          description
        }
      }
    QUERY

    assert_equal 10, data["cohorts"].size
  end

  test "Admins scan see the people in a cohort" do
    10.times { |i| Cohort.create!(name: "Cohort #{i}") }

    bob = Person.create(given_name: "Bob", family_name: "Barker")
    full_stack = Program.create(identifier: "full-stack", title: "Full Stack Web")

    cohort = Cohort.last
    cohort.student_enrollments.create(
      person: bob,
      program: full_stack
    )

    admin_query query: <<-QUERY
      {
        cohorts {
          name
          description
          people {
            givenName
            familyName
          }
        }
      }
    QUERY

    assert_equal "Bob", data["cohorts"].last["people"].first["givenName"]
  end
end
