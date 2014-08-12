# HerokuRakeTasks

Rake tasks to manage an Heroku Application

## Installation

Add this line to your application's Gemfile:

    gem 'heroku_rake_tasks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heroku_rake_tasks

## Usage

```bash
rake h:config                  # Display the application env vars
rake h:console                 # Start a Rails console
rake h:db:dump                 # Dump the remote database to ./remote.dump
rake h:db:restore              # Restore the local database from ./remote.dump
rake h:db:sync                 # Sync the remote database to the local one
rake h:dbconsole               # Start a DB console
rake h:deploy                  # Deploy the application
rake h:deploy:commits          # Show the deployment-pending commits log
rake h:deploy:diff             # Show the deployment-pending source code changes
rake h:deploy:migrate          # Deploy the application and run the migration(s)
rake h:logs                    # Display recent log output for the application
rake h:logs:tail               # Tail the logs for the application
rake h:ps                      # List the application dynos
rake h:restart                 # Restart the application
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/heroku_rake_tasks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
