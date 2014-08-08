
namespace :h do

  desc 'Deploy the application'
  task :deploy do
    deploy
  end

  namespace :deploy do
    desc 'Deploy the application and run the migration(s)'
    task :migrate do
      bundlerize { sh "heroku maintenance:on -r #{remote}" }
      deploy
      bundlerize { sh "heroku run rake db:migrate -r #{remote}" }
      bundlerize { sh "heroku restart -r #{remote}" }
      bundlerize { sh "heroku maintenance:off -r #{remote}" }
    end

    desc 'Show the deployment-pending commits log'
    task :commits do
      bundlerize { sh "git log origin/dev...#{remote}/master --oneline --graph --decorate --no-merges" }
    end

    desc 'Show deployment-pending source ceode changes'
    task :diff do
      bundlerize { sh "git diff origin/dev #{remote}/master --name-only --exit-code" }
    end
  end

  desc 'Display recent log output for the application'
  task :logs do
    bundlerize { sh "heroku logs -r #{remote}" }
    no_warning
  end

  namespace :logs do
    desc 'Tail the logs for the application'
    task :tail do
      bundlerize { sh "heroku logs -t -r #{remote}" }
      no_warning
    end
  end

  desc 'Restart the application'
  task :restart do
    bundlerize { sh "heroku restart -r #{remote}" }
  end

  desc 'Start a Rails console'
  task :console do
    bundlerize { sh "heroku run console -r #{remote}" }
  end

  desc 'Start a DB console'
  task :console do
    bundlerize { sh "heroku pg:psql -r #{remote}" }
  end

  desc 'Display the application env vars'
  task :console do
    bundlerize { sh "heroku config -r #{remote}" }
  end

  desc 'List the application dynos'
  task :console do
    bundlerize { sh "heroku ps -r #{remote}" }
  end

  namespace :db do
    desc 'Sync the remote database to the local one'
    task :sync do
      bundlerize { sh "heroku pgbackups:capture -r #{remote}" }
      download_and_restore
    end

    desc 'Dump the remote database to ./remote.dump'
    task :dump do
      download_and_restore
    end

    desc 'Restore the local database from ./remote.dump'
    task :restore do
      restore
    end
  end

  #--------------------------------------------------------------------------

  def remote
    ARGV.count == 1 ? "staging" : ARGV.last
  end

  def bundlerize
    Bundler.with_clean_env do
      yield
    end
  end

  def deploy
    bundlerize { sh "git push #{remote} origin/#{deploy_branch}:master" }
  end

  def deploy_branch
    case remote
      when "staging"
        "dev"
      when "production"
        "master"
    end
  end

  def download_and_restore
    bundlerize { sh "curl -o remote.dump $(heroku pgbackups:url -r #{remote})" }
    restore
  end

  def restore
    bundlerize { sh "pg_restore -h localhost -U postgres -d #{dev_db_name} remote.dump --verbose --clean --no-acl --no-owner" }
  end

  def dev_db_name
    Rails.configuration.database_configuration["development"]["database"]
  end

  def no_warning
    task remote.to_sym do
    end
  end
end
