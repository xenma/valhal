require 'spec_helper'

  describe "#find_set_number" do

  before(:each) do
    @service = AlephService.new
  end

  it "returns an aleph rec given an isbn" do
#    set = @service.find_set("isbn=9788711396322") 
    set = @service.find_set("isbn=9780691129785")
    rec = @service.get_record(set[:set_num],set[:num_entries])
    puts rec
  end
  
  it "returns an aleph rec given a sys number" do
    set = @service.find_set("sys=008482259") 
    rec = @service.get_record(set[:set_num],set[:num_entries])
    puts rec
  end

end
