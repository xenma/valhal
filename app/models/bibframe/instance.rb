module Bibframe
  # All Bibframe specific logic for Works
  # should live in this module
  module Instance
    extend ActiveSupport::Concern
    included do
      fail 'The host class must extend ActiveFedora::Base!' unless self < ActiveFedora::Base
      has_metadata(name: 'bfMetadata',
                   type: Datastreams::Bibframe::InstanceMetadata)

      has_attributes :note, datastream: 'bfMetadata', multiple: true
      has_attributes :copyright_date, :isbn13, :mode_of_issuance, :title_statement,
                     :extent, :dimensions, datastream: 'bfMetadata', multiple: false

      # Try to delegate to datastream if possible
      def method_missing(meth, *args)
        super unless bfMetadata.respond_to?(meth)
        args = args.first if args.size == 1
        args.present? ? bfMetadata.send(meth, args) : bfMetadata.send(meth)
      end
    end
  end
end
