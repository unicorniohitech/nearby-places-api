source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#Version Ruby
ruby '2.6.3'
# Rails Version
gem 'rails', '~> 5.1.7'
# Postgresql
gem 'pg', '>= 0.18', '< 2.0'
# Puma
gem 'puma', '~> 3.12'
#Bcrypt
gem 'bcrypt', '~> 3.1.7'

gem 'rack-cors'

#Soft Delete
gem 'acts_as_paranoid', '~> 0.6.0'

gem 'jwt'
gem 'simple_command'

gem 'geocoder'

group :development, :test do
  gem 'faker'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
