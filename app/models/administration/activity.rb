# -*- encoding : UTF-8 -*-
module Administration
  class Activity < ActiveFedora::Base
    include Hydra::AccessControls::Permissions


    has_metadata name: 'adminDatastream', type: Datastreams::AdminDatastream
    has_metadata name: 'preservationDatastream', type: Datastreams::PreservationDatastream

  end
end
