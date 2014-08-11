require 'rspec'
require 'pg'
require 'pry'
require 'vhs'

DB = PG.connect({:dbname => 'train_test'})

DB.exec("DELETE FROM lines *;")
DB.exec("DELETE FROM stations *;")

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM stops *;")
  end
end

Vhs.create_classes
