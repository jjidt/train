require 'spec_helper'
require 'line'

describe 'Line' do
  it 'initializes with a name' do
    test_line = Line.new({'name' => 'green'})
    expect(test_line).to be_an_instance_of Line
    expect(test_line.name).to eq 'green'
  end
end
