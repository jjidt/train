require 'rspec'
require 'pg'
require 'pry'
require 'module_sketch'

DB = PG.connect({:dbname => 'train_test'})

DB.exec("DELETE FROM lines *;")
DB.exec("DELETE FROM stations *;")

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
  end
end

Super.create_classes
