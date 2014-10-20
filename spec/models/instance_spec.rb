require 'spec_helper'

describe Instance do
  before :all do
    @element = Instance.new
  end

  it 'has many files' do
    #i = Instance.new
    expect(@element.content_files.size).to eql 0
  end

  it 'should be possible to edit the activity field' do
    @element.activity.should be_nil
    @element.activity = 'TEST'
    @element.activity.should == 'TEST'
  end

  it 'should be possible to edit the workflow_status field' do
    @element.workflow_status.should be_nil
    @element.workflow_status = 'TEST'
    @element.workflow_status.should == 'TEST'
  end

  it 'should be possible to edit the embargo field' do
    @element.embargo.should be_nil
    @element.embargo = 'TEST'
    @element.embargo.should == 'TEST'
  end

  it 'should be possible to edit the embargo_date field' do
    @element.embargo_date.should be_nil
    @element.embargo_date = 'TEST'
    @element.embargo_date.should == 'TEST'
  end

  it 'should be possible to edit the embargo_condition field' do
    @element.embargo_condition.should be_nil
    @element.embargo_condition = 'TEST'
    @element.embargo_condition.should == 'TEST'
  end

  it 'should be possible to edit the access_condition field' do
    @element.access_condition.should be_nil
    @element.access_condition = 'TEST'
    @element.access_condition.should == 'TEST'
  end

  it 'should be possible to edit the copyright field' do
    @element.copyright.should be_nil
    @element.copyright = 'TEST'
    @element.copyright.should == 'TEST'
  end

  it 'should be possible to edit the material_type field' do
     @element.material_type.should be_nil
    @element.material_type = 'TEST'
    @element.material_type.should == 'TEST'
  end

  it 'should be possible to edit the availability field' do
    @element.availability.should be_nil
    @element.availability = 'TEST'
    @element.availability.should == 'TEST'
  end

  it 'should have a uuid on creation' do
    i = Instance.new
    expect(i.uuid).to be_nil
    i.save
    expect(i.uuid.present?).to be true
  end
end

