require 'rspec'
require 'pg'

DB = PG.connect({:dbname => 'train_test'})

DB.exec("DELETE FROM lines *;")
DB.exec("DELETE FROM stations *;")
