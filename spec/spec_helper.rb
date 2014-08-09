require 'rspec'
require 'pg'
require 'pry'
require 'module_sketch'

DB = PG.connect({:dbname => 'train_test'})

DB.exec("DELETE FROM lines *;")
DB.exec("DELETE FROM stations *;")

Super.create_classes
