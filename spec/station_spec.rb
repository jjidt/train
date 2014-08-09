require 'spec_helper'
require 'station'

describe 'Station' do
  it 'initializes with a station name' do
    test_station = Station.new({'name' => '100'})
    expect(test_station).to be_an_instance_of Station
    expect(test_station.name).to eq '100'
  end
end
