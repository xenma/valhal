module Datastreams
  module Bibframe
    # Datastream for modelling all
    # Bibframe::Instance metadata
    class InstanceMetadata < ActiveFedora::OmDatastream
      set_terminology do |t|
        t.root(path:  'Instant', xmlns: 'http://bibframe.org/vocab/')
        t.language do
          t.authority(path: { attribute: 'authority', namespace_prefix: nil })
        end
        t.note
        t.identifier do
          t.identifierValue
          t.identifierScheme
        end
        t.publication do
          t.publicationNote
          t.publicationDate
        end
        t.distribution do
          t.distributionNote
          t.distributionDate
        end
        t.production do
          t.productionNote
          t.productionDate
        end

        t.language_authority(proxy: [:language, :authority])
        t.production_note(proxy: [:production, :productionNote])
        t.production_date(proxy: [:production, :productionDate])
        t.distribution_note(proxy: [:distribution, :distributionNote])
        t.distribution_date(proxy: [:distribution, :distributionDate])
        t.publication_note(proxy: [:publication, :publicationNote])
        t.publication_date(proxy: [:publication, :publicationDate])
        t.identifier_value(proxy: [:identifier, :identifierValue])
        t.identifier_scheme(proxy: [:identifier, :identifierScheme])
      end

      def self.xml_template
        Nokogiri::XML.parse('<bf:Instance xmlns:bf="http://bibframe.org/vocab/">')
      end
    end
  end
end
