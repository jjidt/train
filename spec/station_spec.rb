require 'spec_helper'

describe 'Station' do
  it 'initializes with a station name' do
    test_station = Vhs::Station.new('name' => '100')
    expect(test_station).to be_an_instance_of Vhs::Station
    expect(test_station.name).to eq '100'
  end

  describe '.create' do
    it 'creates a new station to the database' do
      test_station = Vhs::Station.new('name' => '100')
      create_id = test_station.create
      expect(test_station.id).to eq create_id
    end
  end

  describe '.read' do
    it 'reads a station from the database by name' do
      test_station = Vhs::Station.new('name' => '200')
      test_station2 = Vhs::Station.new('name' => 'bologna')
      test_station.create
      test_station2.create
      expect(Vhs::Station.read('name' => '200').first.name).to eq test_station.name
    end
  end

  describe '.update' do
    it 'updates information for a station in the database' do
      test_station = Vhs::Station.new('name' => '200')
      test_station2 = Vhs::Station.new('name' => 'bologna')
      test_station.create
      create_id2 = test_station2.create
      Vhs::Station.update({'name' => '300'}, {'id' => create_id2})
      expect(Vhs::Station.read('id' => create_id2).first.name).to eq '300'
    end
  end

  describe '.join_by_name' do
    it 'finds the stations for a given train line' do
      test_station = Vhs::Station.new('name' => '200')
      test_station2 = Vhs::Station.new('name' => '300')
      test_station_id = test_station.create
      test_station2_id = test_station2.create
      test_line = Vhs::Line.new('name' => 'green')
      test_line2 = Vhs::Line.new('name' => 'blue')
      test_line3 = Vhs::Line.new('name' => 'red')
      test_line_id = test_line.create
      test_line2_id = test_line2.create
      test_line3_id = test_line3.create
      test_stop = Vhs::Stop.new('station_id' => '1', 'line_id' => '1')
      test_stop2 = Vhs::Stop.new('station_id' => '1', 'line_id' => '3')
      test_stop3 = Vhs::Stop.new('station_id' => '2', 'line_id' => '1')
      test_stop.create
      test_stop2.create
      test_stop3.create
      binding.pry
      expect(Vhs::Station.join_by_name('right_table' => 'lines', 'join_table' => 'stops', 'name' => 'green').length).to eq 2
    end
  end
end
