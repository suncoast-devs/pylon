## Contributing

See the [Nexus](https://github.com/suncoast-devs/nexus) repository for instructions on setting up the UI portion of `nexus+pylon`.

- Install Ruby with your favorite method. See [`.ruby-version`](https://github.com/suncoast-devs/pylon/blob/master/.ruby-version) for the required version. We recommend [`chruby`](https://github.com/postmodern/chruby) and [`ruby-install`](https://github.com/postmodern/ruby-install)
- Run `bundle install` to ensure all gems are installed and present.
- To get setup with a login, run `rails db:setup`.
- Execute `rails server` to run the server on port `3000`. **NOTE** You should run this first and then run the client UI in a second session so the UI will run on port `3001`

---

_**You Must Construct Additional Pylons**_