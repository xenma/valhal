module Validator

  class Xml < ActiveModel::Validator
    @schema_file = ""

    def validate(record) 
      return is_valid record
    end

    def set_schema(schema)
      @schema_file = schema
    end

    def get_schema()
      return @schema
    end

    def schema_selector(file_name)
      file = File.new(file_name)
      ext =  File.extname(file_name)
      case ext
      when '.xsd'
        return Nokogiri::XML::Schema(open(file).read)
      when '.rng'
        return Nokogiri::XML::RelaxNG(open(file).read)
      else
        raise "XML schema language #{ext} is not supported!"
      end
    end
    
    def is_valid(record)
      if record.mime_type != "text/xml"
        record.errors[:base] << "This object is not XML"
      else
        msg = ""
        begin
          xdoc = Nokogiri::XML.parse(record.datastreams['content'].content) { |config| config.strict }

          unless @schema_file.blank?
            xval = schema_selector(@schema_file)
            xval.validate(xdoc).each do |error|
              msg = msg + "\n" + error.message
            end
            record.errors[:base] = msg
            if msg.blank?
              return true
            else
              return false
            end
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
