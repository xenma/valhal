require 'spec_helper'
require 'fakeredis'
require 'resque'


describe 'Send object to preservation' do

  before :all do
    valid_attributes = { activity: @default_activity_id, copyright: 'Some Copyright',  collection: 'Some Collection'}
    @i = Instance.create(valid_attributes)
  end

  before :each do
    @i.preservation_state = PRESERVATION_STATE_INITIATED.keys.first
    @i.save
  end


  describe 'perform', :broken=>true do


    after :each do
      @i.preservation_state = PRESERVATION_STATE_INITIATED.keys.first
    end

    it 'without cascading' do
      SendToPreservationJob.perform(@i.pid,false)
      @i.preservation_state.should eql PRESERVATION_REQUEST_SEND
    end
  end
end

