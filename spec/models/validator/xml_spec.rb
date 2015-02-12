require 'spec_helper'

describe 'content' do

  it 'should not complain about valid files' do
    c = ContentFile.new
    v = Validator::Xml.new
    doc = 'holb06valid.xml'
    f = File.new(Pathname.new(Rails.root).join('spec', 'fixtures',doc))
    c.add_file(f)
    c.save
    puts "******\n" + doc
    isOK = v.validate c
    msg = c.errors[:base].join(" ")
    puts msg
    expect(isOK).to be true
  end

  it 'should allow to test the validity of files' do
    c = ContentFile.new
    v = Validator::Xml.new
    doc = 'holb06invalid.xml'
    f = File.new(Pathname.new(Rails.root).join('spec', 'fixtures',doc))
    c.add_file(f)
    c.save
    puts "******\n" + doc
    isOK = v.validate c
    msg = c.errors[:base].join(" ")
    puts msg
    expect(isOK).to be false
  end

  it 'should also capture files that are not wellformed' do
    c = ContentFile.new
    v = Validator::Xml.new
    doc = 'holb06notwellformed.xml'
    f = File.new(Pathname.new(Rails.root).join('spec', 'fixtures',doc))
    c.add_file(f)
    c.save
    puts "******\n" + doc
    isOK = v.validate c
    msg = c.errors[:base].join(" ")
    puts msg
    expect(isOK).to be false
  end

end
