source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'ridgepole', '0.6.5.beta14'#,'0.5.4', git: 'git@github.com:winebarrel/ridgepole.git'

gem 'slim-rails'
gem 'nokogiri'

gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'font-awesome-sass'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails-footnotes'
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
end

gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'vuejs-rails', '1.0.26'

gem 'rails-i18n', '~> 5.0.0'

gem 'dotenv-rails', groups: %i[development test]

gem 'rack-cors', require: 'rack/cors'

gem 'addressable'

gem 'typhoeus'

gem 'breadcrumbs_on_rails'
