require 'spec_helper'

describe 'Line' do
  it 'initializes with a name' do
    test_line = Vhs::Line.new('name' => 'green')
    expect(test_line).to be_an_instance_of Vhs::Line
    expect(test_line.name).to eq 'green'
  end

  describe 'create' do
    it 'creates a new line in the database' do
      test_line = Vhs::Line.new('name' => 'green')
      create_id = test_line.create
      expect(test_line.id).to eq create_id
    end
  end

  describe '.read' do
    it 'reads a specified line from a table in the database' do
      test_line = Vhs::Line.new('name' => 'blah')
      test_line2 = Vhs::Line.new('name' => 'blah2')
      create_id = test_line.create
      test_line2.create
      expect(Vhs::Line.read('name' => 'blah', 'id' => create_id).first.name).to eq 'blah'
    end

    it 'reads all lines from a table in the database' do
      test_line = Vhs::Line.new('name' => 'blah')
      test_line2 = Vhs::Line.new('name' => 'blah2')
      test_line.create
      test_line2.create
      expect(Vhs::Line.read("'*'" => '*').length).to eq 2
    end
  end

  describe '.update' do
    it 'updates column info for a specified row' do
      test_line = Vhs::Line.new('name' => 'green')
      test_line2 = Vhs::Line.new('name' => 'blue')
      create_id = test_line.create
      test_line2.create
      Vhs::Line.update({'name' => 'red'}, {'id' => create_id})
      expect(Vhs::Line.read('id' => create_id).first.name).to eq 'red'
    end
  end

  describe '.delete' do
    it 'removes an item from the database' do
      test_line = Vhs::Line.new('name' => 'green')
      test_line2 = Vhs::Line.new('name' => 'red')
      test_line.create
      test_line2.create
      Vhs::Line.delete('name' => 'red')
      expect(Vhs::Line.read("'*'" => '*').length).to eq 1
    end
  end

  describe '.list' do
    it 'reads all lines from a table in the database' do
      test_line = Vhs::Line.new('name' => 'blah')
      test_line2 = Vhs::Line.new('name' => 'blah2')
      test_line.create
      test_line2.create
      expect(Vhs::Line.list.length).to eq 2
    end
  end
end
