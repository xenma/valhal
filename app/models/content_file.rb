# This class should be used to represent
# all content datastreams. File order should
# be given on the Instance level.
class ContentFile < ActiveFedora::Base
  include Hydra::AccessControls::Permissions
  include Concerns::Preservation

  has_file_datastream 'file'
  belongs_to :instance, property: :content_for

  before_save :set_rights_metadata

  def can_perform_cascading?
    false
  end

  def set_rights_metadata
    a = Administration::Activity.find(self.instance.activity)
    self.edit_groups = a.permissions['file']['group']['edit']
    self.read_groups = a.permissions['file']['group']['read']
    self.discover_groups = a.permissions['file']['group']['discover']
  end
end
