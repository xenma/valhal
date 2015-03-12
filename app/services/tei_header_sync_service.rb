# Responsible for keeping the teiHeader in sync with the hydra chronos metadata
class TeiHeaderSyncService
  attr_accessor :file,:sheet,:params
  def initialize(file, sheet, params)
    @xslt = Nokogiri::XSLT(File.read(sheet))
    @aleph_marc = marc
  end

  def update_header(@file,@params)
    doc = Nokogiri::XML.parse(@file) { |config| config.strict }
    @xslt.transform(doc, Nokogiri::XSLT.quote_params(params))
  end

end
