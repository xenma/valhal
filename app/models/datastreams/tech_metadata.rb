# -*- encoding : utf-8 -*-
module Datastreams

  # Datastream for technical content_file metadata
  class TechMetadata < ActiveFedora::OmDatastream

    # Inserted maintain existing naming of solr fields in Activefedora 8
    # And thus avoid anoing deprecation warning messages
    def prefix
      ""
    end

    set_terminology do |t|
      t.root(:path=>'fields')
      t.uuid
      t.file_checksum
      t.original_filename
      t.mime_type
      t.file_size
      t.last_modified
      t.created
      t.last_accessed
      t.file_uuid
      t.editable
      t.validator
    end

    def self.xml_template
      Nokogiri::XML.parse('<fields/>')
    end
  end
end