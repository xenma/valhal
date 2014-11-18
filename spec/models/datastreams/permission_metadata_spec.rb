require 'spec_helper'

describe Datastreams::PermissionMetadata do
  before :all do
    file = File.new('./spec/fixtures/default_permissions.xml')
    @ds = Datastreams::PermissionMetadata.from_xml(file)
  end

  describe 'file permissions' do
    it 'should return an array' do
      @ds.get_file_permissions.should be_an Array
    end

    it 'should have a name' do
      @ds.get_file_permissions.first['name'].should eql 'chronos-alle'
    end

    it 'should have an access' do
      @ds.get_file_permissions.first['access'].should eql'discover'
    end

    it 'should have a type' do
      @ds.get_file_permissions.first['type'].should eql 'group'
    end

    it 'should be able to add a set of file permissions' do
      expect {
        @ds.add_file_permission('chronos-nsa','discover','group')
      }.to change{@ds.get_file_permissions}.by([{"name"=>"chronos-nsa", "access"=>"discover", "type"=>"group"}])
    end
  end
end
