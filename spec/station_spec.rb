require 'spec_helper'
require 'station'

describe 'Station' do
  it 'initializes with a station name' do
    test_station = Super::Stations.new({'name' => '100'})
    expect(test_station).to be_an_instance_of Super::Stations
    expect(test_station.name).to eq '100'
  end

  describe '.create' do
    it 'creates a new station to the database' do
      test_station = Super::Stations.new({'name' => '100'})
      create_id = test_station.create
      expect(test_station.id).to eq create_id
    end
  end

  describe '.read' do
    it 'reads a station from the database by name' do
      test_station = Super::Stations.new({'name' => '200'})
      test_station2 = Super::Stations.new({'name' => 'bologna'})
      test_station.create
      test_station2.create
      expect(Super::Stations.read({'name' => '200'}).first.name).to eq test_station.name
    end
  end

  describe '.update' do
    it 'updates information for a station in the database' do
      test_station = Super::Stations.new({'name' => '200'})
      test_station2 = Super::Stations.new({'name' => 'bologna'})
      test_station.create
      create_id2 = test_station2.create
      Super::Stations.update({'name' => '300'}, {'id' => create_id2})
      expect(Super::Stations.read({'id' => create_id2}).first.name).to eq '300'
    end
  end
end
