module Bibframe
  # All Bibframe specific logic for Works
  # should live in this module
  module Work
    extend ActiveSupport::Concern

    included do
      fail 'The host class must extend ActiveFedora::Base!' unless self < ActiveFedora::Base

      has_metadata name: 'bfMetadata', type: Datastreams::Bibframe::WorkMetadata
      has_attributes :note, datastream: 'bfMetadata', multiple: true

      # Try to delegate to datastream if possible
      def method_missing(meth, *args)
        super unless bfMetadata.respond_to?(meth)
        args = args.first if args.size == 1
        args.present? ? bfMetadata.send(meth, args) : bfMetadata.send(meth)
      end
    end
  end
end
