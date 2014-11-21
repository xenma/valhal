module Administration
  class Activity < ActiveFedora::Base

    include Hydra::AccessControls::Permissions
    include Concerns::AdminMetadata
    include Concerns::Preservation

    validates :activity, presence: true

    def can_perform_cascading
      false
    end
  end
end
