require 'spec_helper'

describe 'content' do

  it 'should allow to test the validity of files' do
    c = ContentFile.new
    puts Rails.root + '/../adl_data/texts/holb06val.xml'
    f = File.new(Pathname.new(Rails.root).join('..','adl_data','texts','holb06val.xml'))
    c.add_file(f)
    c.save
    puts '******'
    puts c.datastreams['content'].content
  end

end
