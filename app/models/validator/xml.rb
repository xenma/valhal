module Validator

  class Xml < ActiveModel::Validator
    
    def validate(record) 
      return is_valid record
    end
    
    def is_valid(record)
      if record.mime_type != "text/xml"
        record.errors[:base] << "This object is not XML"
      else
        schema = File.new(Rails.root.join('spec', 'fixtures', 'tei_all.rng'))
        xval = Nokogiri::XML::RelaxNG(open(schema).read)
        msg = ""
        begin

          xdoc = Nokogiri::XML.parse(record.datastreams['content'].content) { |config| config.strict }

          xval.validate(xdoc).each do |error|
            msg = msg + "\n" + error.message
          end

          record.errors[:base] = msg
          if msg.blank?
            return true
          else
            return false
          end

        rescue Exception => wellformedness
          msg = wellformedness
          record.errors[:base] = msg
          return false
        end

      end

    end
  end
end
