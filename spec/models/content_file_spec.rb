require 'spec_helper'

describe 'content' do

  it 'should allow us to upload a file' do
    c = ContentFile.new
    f = File.new(Pathname.new(Rails.root).join('spec', 'fixtures', 'test_instance.xml'))
    c.add_file(f)
  end

  it 'has a relation to an instance' do
    i = Instance.new
    c = ContentFile.new
    c.instance = i
    expect(c.instance).to eql i
  end
end
