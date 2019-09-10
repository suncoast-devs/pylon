**You Must Construct Additional Pylons**

Contributing:

See [nexus](https://github.com/suncoast-devs/nexus) for instructions on setting up the UI portion of nexus+pylon.

**NOTE** You should run the `rails server` first and then run the UI in a second session so it will run on port `3001`

Install Ruby with your favorite method. See [`.ruby-version`](https://github.com/suncoast-devs/pylon/blob/master/.ruby-version) for the required version.

Run `bundle install` to ensure all the gems are install and present.

`rails server` to run the server on port `3000`


To get setup, create at least a single person in the system, enter the following into a `rails console` session

```ruby

program = Program.create(title: 'Full Stack')
cohort = Cohort.create(program: program, name: 'Cohort', start_date: Date.today, end_date: 120.days.from_now)

person = Person.create(given_name: 'Darth', family_name: 'Vader', full_name: 'Darth Vader')

StudentEnrollment.create(person: person, cohort: chort)
```

The StudentEnrollment will create an invite code, use that code to login to the system as a student would.
You will need the `nexus` UI running and use an URL like: `http://localhost:3001/redeem/6542555` replacing
the code above with the invite code from the StudentEnrollment model.

Once this is done you will have a `User` entry. To make that user an admin:

```ruby

user = User.last
user.update(is_admin: true)
```
