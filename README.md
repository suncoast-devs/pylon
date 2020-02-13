**You Must Construct Additional Pylons**

Contributing:

See [nexus](https://github.com/suncoast-devs/nexus) for instructions on setting up the UI portion of nexus+pylon.

**NOTE** You should run the `rails server` first and then run the UI in a second session so it will run on port `3001`

Install Ruby with your favorite method. See [`.ruby-version`](https://github.com/suncoast-devs/pylon/blob/master/.ruby-version) for the required version. We recommend [`chruby`](https://github.com/postmodern/chruby) and [`ruby-install`](https://github.com/postmodern/ruby-install)

Run `bundle install` to ensure all the gems are install and present.

To get setup with a login, run the following command:

`rails db:setup`

Then execute

`rails server` to run the server on port `3000`
