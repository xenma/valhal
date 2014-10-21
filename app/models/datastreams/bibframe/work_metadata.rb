module Datastreams
  module Bibframe
    # Datastream for modelling all Bibframe::Work metadata
    class WorkMetadata < Datastreams::Bibframe::Resource
      set_terminology do |t|
        t.root(path:  'Work', xmlns: 'http://bibframe.org/vocab/')
        t.title do
          t.Title
        end
        t.language do
          t.authority(path: { attribute: 'authority', namespace_prefix: nil })
        end

        t.note
        t.subject do
          t.Topic do
            t.label
          end
        end

        t.systemNumber do
          t.Identifier do
            t.identifierValue
          end
        end

        t.language_authority(proxy: [:language, :authority])
      end

      # Create an Array of Title objects
      # based on the title.Title nodeset
      def titles
        title.Title.nodeset.map { |n| Title.new(n) }
      end

      def self.xml_template
        Nokogiri::XML.parse('<bf:Work xmlns:bf="http://bibframe.org/vocab/">')
      end
    end

    # present easy accessors for title attributes
    class Title
      attr_reader :type, :values, :subtitle

      # Create new object from a Nokogiri::XML::Element
      def initialize(xml)
        @type = xml.css('bf|titleType').text
        @subtitle = xml.css('bf|subtitle').text
        @values = []
        xml.css('bf|titleValue').each do |n|
          @values << TitleValue.new(n.text, n.attribute('lang').text)
        end
      end

      # holds title values
      class TitleValue
        attr_reader :value, :lang

        def initialize(value, lang)
          @value = value
          @lang = lang
        end
      end
    end
  end
end
