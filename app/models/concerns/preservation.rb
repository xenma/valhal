# -*- encoding : utf-8 -*-
module Concerns
  # The preservation definition which is to be used by all elements.
  # Adds the preservation metadata datastream, and sets up default values.
  module Preservation
    extend ActiveSupport::Concern

    included do
      include ActiveFedora::Callbacks # to be able to define the 'before_validation' method
      include Rails.application.routes.url_helpers

      has_metadata :name => 'preservationMetadata', :type => Datastreams::PreservationDatastream
      has_attributes :preservation_profile, :preservation_state, :preservation_details, :preservation_modify_date,
                     :preservation_comment, :warc_id, :preservation_bitsafety, :preservation_confidentiality,
                     datastream: 'preservationMetadata', :multiple => false

      validate :validate_preservation

      before_save do
        logger.debug("now saving #{self.class.name} - #{self.pid}")
      end

      before_validation :update_preservation_profile

      def update_preservation_profile
        logger.debug("update preservation profile")
        logger.debug("update preservation file for #{self.class.name} - #{self.pid} - #{self.preservation_profile}")
        self.preservation_profile = 'Undefined' if self.preservation_profile.blank?
        self.preservation_state = Constants::PRESERVATION_STATE_NOT_STARTED.keys.first if preservation_state.blank?
        self.preservation_details = 'N/A' if preservation_details.blank?
        if Constants::PRESERVATION_CONFIG['preservation_profile'].keys.include? self.preservation_profile
          self.preservation_bitsafety = Constants::PRESERVATION_CONFIG['preservation_profile'][self.preservation_profile]['bit_safety']
          self.preservation_confidentiality = Constants::PRESERVATION_CONFIG['preservation_profile'][self.preservation_profile]['confidentiality']
        end
        set_preservation_modified_time
        logger.debug("update preservation profile END")
      end

      def validate_preservation
        logger.debug("validate preservation")
        if (self.preservation_profile != 'Undefined' && (!Constants::PRESERVATION_CONFIG['preservation_profile'].include? self.preservation_profile))
          errors.add(:preservation_profile,'Ugyldig Bevaringsprofil')
          logger.debug("is invalid")
        end
        logger.debug("validate preservation END")
      end


      # Check whether it should be cascading, and also perform the cascading.
      # @param params The parameter from the controller. Contains the parameter for whether the preservation
      # should be cascaded.
      # @param element The element to have stuff cascaded.
      def cascade_preservation
        self.reload
        logger.debug("cascade preservation#{self.class.name} - #{self.pid} ")
        if self.can_perform_cascading?
          self.cascading_elements.each do |pib|
            logger.debug("#{pib.class}")
            pib.preservation_profile = self.preservation_profile
            pib.save
          end
        end
        logger.debug("cascade preservation END #{self.class.name} - #{self.pid}")
      end


      # Initiates the preservation. If the profile is set to long-term preservation, then a message is created and sent.
      # @param element The element to perform the preservation upon.
      def initiate_preservation
        logger.debug("initiating preservation")
        profile = Constants::PRESERVATION_CONFIG['preservation_profile'][self.preservation_profile]

        if profile['yggdrasil'].blank? || profile['yggdrasil'] == 'false'
          self.preservation_state = Constants::PRESERVATION_STATE_NOT_LONGTERM.keys.first
          self.preservation_details = 'Not longterm preservation.'
          self.save
        else
          self.preservation_state = Constants::PRESERVATION_STATE_INITIATED.keys.first
          self.preservation_details = 'The preservation button has been pushed.'
          message = create_preservation_message
          self.save && send_message_to_preservation(message)
        end

        if self.can_perform_cascading?
          self.cascading_elements.each do |pib|
            pib.initiate_preservation
          end
        end

        logger.debug("initiating preservation END")
      end

      private
      def create_preservation_message
        message = Hash.new
        message['UUID'] = self.uuid
        message['Preservation_profile'] = self.preservationMetadata.preservation_profile.first
        message['Valhal_ID'] = self.pid
        message['Model'] = self.class.name

        if self.kind_of?(ContentFile)
          message['File_UUID'] = self.file_uuid
          message['Content_URI'] = url_for(:controller => 'view_file', :action => 'show', :pid =>self.pid, :only_path => true)
        end

        metadata = create_message_metadata
        message['metadata'] = metadata

        message.to_json
      end

      # Creates the metadata part of the message.
      # @return The metadata for the element.
      def create_message_metadata
        res = '<metadata>'
        res = self.create_preservation_message_metadata
        res + '</metadata>'
      end

      def set_preservation_modified_time
        self.preservationMetadata.preservation_modify_date = DateTime.now.strftime("%FT%T.%L%:z")
      end
    end
  end
end