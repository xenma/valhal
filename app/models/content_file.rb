# This class should be used to represent
# all content datastreams. File order should
# be given on the Instance level.
class ContentFile < ActiveFedora::Base
  has_file_datastream 'file'
  belongs_to :instance, property: :content_for
end
