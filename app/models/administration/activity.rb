module Administration
  class Activity < ActiveFedora::Base

    include Hydra::AccessControls::Permissions
    include Concerns::AdminMetadata
    include Concerns::Preservation

    validates :activity, presence: true

    before_save do
      self.edit_groups = ['Chronos-Admin']
      self.read_groups = ['Chronos-Alle']
    end

    def can_perform_cascading
      false
    end
  end
end
