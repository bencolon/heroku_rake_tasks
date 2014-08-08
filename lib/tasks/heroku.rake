
namespace :h do

  desc 'Deploy the application'
  task :deploy do
    bundlerize { sh "git push #{remote} origin/#{deploy_branch}:master" }
  end

  namespace :deploy do
    desc 'Deploy the application and run the migration(s)'
    task :deploy do
      bundlerize { sh "heroku maintenance:on -r #{remote}" }
      bundlerize { sh "git push #{remote} origin/#{deploy_branch}:master" }
      bundlerize { sh "heroku run rake db:migrate -r #{remote}" }
      bundlerize { sh "heroku restart -r #{remote}" }
      bundlerize { sh "heroku maintenance:off -r #{remote}" }
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

  #--------------------------------------------------------------------------

  def remote
    ARGV.count == 1 ? "staging" : ARGV.last
  end

  def bundlerize
    Bundler.with_clean_env do
      yield
    end
  end

  def deploy_branch
    case remote
      when "staging"
        "dev"
      when "production"
        "master"
    end
  end

  def no_warning
    task remote.to_sym do
    end
  end
end
