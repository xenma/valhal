require 'spec_helper'

describe  TeiHeaderSyncService do

  before do
    @file = File.new("#{Rails.root}/spec/fixtures/holb06valid.xml")
    xsl = File.new("#{Rails.root}/app/services/xslt/tei_header_sed.xsl")
    @sync_service = TeiHeaderSyncService.new(xsl)
  end

 describe 'update_header' do
    before :all do 
      @instance = Instance.create
      @work     = Work.create
    end
   
  end
end
