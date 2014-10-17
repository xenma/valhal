# This is a KB Instance.
# Only KB specific logic should
# live in this class. All domain logic
# e.g. Bibframe, Hydra::Rights etc,
# should live in separate modules and
# be mixed in.
class Instance < ActiveFedora::Base
  include Bibframe::Instance
  belongs_to :work, property: :instance_of
  has_many :content_files, property: :content_for
  has_metadata :name => 'preservationMetadata', :type => Datastreams::PreservationDatastream
end