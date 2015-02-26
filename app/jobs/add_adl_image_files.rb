require 'resque'

class AddAdlImageFiles

  def self.perform(content_file_id)

    begin
      cf = ContentFile.find(content_file_id)
      tei_inst = cf.content_for







    rescue ActiveFedora::ObjectNotFoundError => e
      Resque.logger.error("Object not found #{e.message}")
    end
  end
end