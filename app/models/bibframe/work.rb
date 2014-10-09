module Bibframe
  # All Bibframe specific logic for Works
  # should live in this module
  module Work
    extend ActiveSupport::Concern
    included do
      has_metadata(name: 'bfMetadata',
                   type: Datastreams::Bibframe::WorkMetadata)
      has_attributes(:title, :uniform_title,
                     datastream: 'bfMetadata', multiple: false)
      has_attributes(:language, datastream: 'bfMetadata', multiple: true)
    end
  end
end
