#Plain old Ruby object for containing parameters for initiating preservation workflow
module Yggdrasil
  class PreservationRequest

    #Following constants are preservation profiles
    PRESERVATION_PROFILE_ETERNITY = 'eternity'
    PRESERVATION_PROFILE_SIMPLE = 'simple'
    PRESERVATION_PROFILE_STORAGE = 'storage'

    COMMIT_PRESERVATION = true

    attr_reader :preservation_profile, :comment, :commit_preservation

    def initialize(preservation_profile, comment, commit_preservation)
      raise ArgumentError, "Invalid preservation profile: #{preservation_profile}" unless preservation_profile.eql? PRESERVATION_PROFILE_ETERNITY || PRESERVATION_PROFILE_SIMPLE || PRESERVATION_PROFILE_STORAGE
      raise ArgumentError, "Invalid commit preservation value: #{commit_preservation}" unless commit_preservation.eql? 'true' || 'false'
      @preservation_profile = preservation_profile
      @comment = comment
      @commit_preservation = commit_preservation
    end

  end
end