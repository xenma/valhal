require 'fileutils'

# This class should be used to represent
# all content datastreams. File order should
# be given on the Instance level.
class ContentFile < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include Concerns::TechMetadata
  include Concerns::Preservation
  include Concerns::UUIDGenerator

  belongs_to :instance, property: :content_for

  validate :custom_validations

  def custom_validations
    valid = true
    self.validator.each do |vname|
      classname = "Validator::#{vname}"
      begin
        klass = Module.const_get(classname)
        if (klass <= ActiveModel::Validator)
          v = klass.new
          isOK = v.validate self
          valid = valid && isOK
        else
          logger.warn("Validator #{vname} for ContentFile is not a Validator")
        end
      rescue NameError => e
        logger.warn("Validator #{vname} for ContentFile not defined")
      end
    end
    valid
  end

  def add_external_file(path)
    file_name = Pathname.new(path).basename.to_s
    logger.debug("filename #{file_name}")
    mime_type = mime_type_from_ext(file_name)
    logger.debug("mime_type #{mime_type}")

    attrs = {:dsLocation => "file://#{path}", :controlGroup => 'E', :mimeType => mime_type, :prefix=>''}
    ds = ActiveFedora::Datastream.new(inner_object,'content',attrs)

    file_object = File.new(path)
    set_file_timestamps(file_object)
    self.checksum = generate_checksum(file_object)
    self.original_filename = file_name
    self.mime_type = mime_type
    self.size = file_object.size.to_s
    self.file_uuid = UUID.new.generate

    datastreams['content'] = ds
  end


  # Adds a content datastream to the object and generate techMetadata for the basic_files
  # basic_files may either be File or UploadedFile objects.
  #
  # @param file (ActionDispatch::Http:UploadedFile | File)
  # @param skip_fits boolean
  def add_file(file)
    if file.class == ActionDispatch::Http::UploadedFile
      file_object = file.tempfile
      file_name = file.original_filename
      mime_type = file.content_type
    elsif file.class == File
      file_object = file
      file_name = Pathname.new(file.path).basename.to_s
      mime_type = mime_type_from_ext(file_name)
    else
      return false
    end

    self.add_file_datastream(file_object, label:  file_name, mimeType: mime_type, dsid: 'content')
    set_file_timestamps(file_object)
    self.checksum = generate_checksum(file_object)
    self.original_filename = file_name
    self.mime_type = mime_type
    self.size = file.size.to_s
    self.file_uuid = UUID.new.generate
    true
  end

  def mime_type_from_ext(file_name)
    ext =  File.extname(file_name)
    case ext
      when '.pdf'
        'application/pdf'
      when '.xml'
        'text/xml'
      when '.tif', '.tiff'
        'image/tiff'
      when '.jpg', '.jpeg'
        'image/jpeg'
      when '.txt'
        'text/plain'
      else
        raise "no mimetype found for extension #{ext}!"
    end
  end

  # Extracts the timestamps from the file and inserts them into the technical metadata.
  # @param file The file to extract the timestamps of.
  def set_file_timestamps(file)
    self.created = file.ctime.to_s
    self.last_accessed = file.atime.to_s
    self.last_modified = file.mtime.to_s
  end


  ## Model specific preservation functionallity
  def create_preservation_message_metadata

    res = "<provenanceMetadata><fields><uuid>#{self.uuid}</uuid></fields></provenanceMetadata>"
    res +="<preservationMetadata>"
    res += self.preservationMetadata.content
    res +="</preservationMetadata>"
    res +="<techMetadata>"
    res += self.techMetadata.content
    res +="</techMetadata>"
  end

  def can_perform_cascading?
    false
  end

  private
  def generate_checksum(file)
    Digest::MD5.file(file).hexdigest
  end

  # Extracts the timestamps from the file and inserts them into the technical metadata.
  # @param file The file to extract the timestamps of.
  def set_file_timestamps(file)
    self.created = file.ctime.to_s
    self.last_accessed = file.atime.to_s
    self.last_modified = file.mtime.to_s
  end

end
