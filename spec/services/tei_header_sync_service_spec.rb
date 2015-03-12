require 'spec_helper'

describe  TeiHeaderSyncService do

  before do
    rec = @service.get_record(set[:set_num],set[:num_entries])
    @converter = ConversionService.new(rec)
  end

 describe 'update_header' do
    before :all do 
      @instance = Instance.create
    end
    it 'is wellformed XML' do
      xsd = Nokogiri::XML::Schema(open('http://www.loc.gov/standards/mods/v3/mods-3-5.xsd').read)
      doc = @converter.to_mods("")
      puts @converter.to_marc21("")
      puts doc.to_xml
      errors = xsd.validate(doc) { |config| config.strict }
      expect(errors).to eql []
    end
  end
end
