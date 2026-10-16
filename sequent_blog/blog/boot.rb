ENV['SEQUENT_ENV'] ||= 'development'

require './app/web'

Sequent::Support::Database.connect!(ENV['SEQUENT_ENV'])
