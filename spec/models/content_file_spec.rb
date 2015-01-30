require 'spec_helper'

describe ContentFile do



  it 'has a relation to an instance' do
    i = Instance.new
    c = ContentFile.new
    c.instance = i
    expect(c.instance).to eql i
  end

  it 'can have a label' do
    c = ContentFile.new
    c.file_label = 'test label'
    expect(c.file_label).to eql 'test label'
  end

  context 'when adding files' do
    before :each do
      f = File.new(Pathname.new(Rails.root).join('spec', 'fixtures', 'test_instance.xml'))
      @cf = ContentFile.new
      @cf.add_file(f)
    end

    it 'should allow us to upload a file' do
      expect(@cf.content).to be_a ActiveFedora::Datastream
    end

    it 'takes filename as its label if none specified' do
      expect(@cf.file_label).to eql 'test_instance.xml'
    end
  end
end
