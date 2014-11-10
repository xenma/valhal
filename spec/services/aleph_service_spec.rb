require 'spec_helper'

  describe "#find_set_number" do

  before(:each) do
    @service = AlephService.new
  end

  it "returns an aleph set number" do
    set = @service.find_set("isbn=9788711396322") 
    rec = @service.get_record(set[:set_num],set[:num_entries])
    puts rec
  end
end
