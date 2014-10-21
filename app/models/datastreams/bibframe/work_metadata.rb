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

        t.identifier do
          t.Identifier
        end
        t.language do
          t.Language
        end
        t.language_authority(proxy: [:language, :authority])
      end

      define_template :title do |xml, type, subtitle, lang, value|
        xml.title do
          xml.Title do
            xml.titleType { xml.text(type) }
            xml.subtitle { xml.text(subtitle) }
            lang_attr = { 'xml:lang' => lang }
            xml.titleValue(lang_attr) { xml.text(value) }
          end
        end
      end

      # Create an Array of Title objects
      # based on the title.Title nodeset
      def titles
        title.Title.nodeset.map { |n| Title.new(n) }
      end

      # Return only the title values - useful for indexing
      def title_values
        vals = []
        titles.each { |t| vals << t.values.map(&:value) }
        vals.flatten
      end

      def add_title(title_hash)
        sibling = find_by_terms(:title).last
        if sibling
          node = add_next_sibling_node(sibling, :title, title_hash[:type], title_hash[:subtitle],
                                       title_hash[:lang], title_hash[:value])
        else
          node = add_child_node(ng_xml.root, :title, title_hash[:type], title_hash[:subtitle],
                                title_hash[:lang], title_hash[:value])
        end
        content_will_change!
        node
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
