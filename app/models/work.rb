# This class represents a Work model in
# Fedora. Only KB specific logic should
# live in this class. All domain logic
# e.g. Bibframe, Hydra::Rights etc,
# should live in separate modules and
# be mixed in.
class Work < ActiveFedora::Base
  include Bibframe::Work
  include Hydra::AccessControls::Permissions
  include Concerns::UUIDGenerator
  has_many :instances, property: :instance_of
  has_and_belongs_to_many :related_works, class_name: 'Work', property: :related_work, inverse_of: :related_work
  has_and_belongs_to_many :preceding_works, class_name: 'Work', property: :preceded_by, inverse_of: :succeeded_by
  has_and_belongs_to_many :succeeding_works, class_name: 'Work', property: :succeeded_by, inverse_of: :preceded_by
  has_and_belongs_to_many :creators, class_name: 'Authority::Base', property: :creator, inverse_of: :creator_of
  # use this as an accessor for related_works
  # to ensure the relationship is symmetrical
  def add_related(work)
    related_works << work
    work.related_works << self
  end

  # use this as an accessor for preceding_works
  # to ensure the relationship is symmetrical
  def add_preceding(work)
    preceding_works << work
    work.succeeding_works << self
  end

  # use this as an accessor for succeeding_works
  # to ensure the relationship is symmetrical
  def add_succeeding(work)
    succeeding_works << work
    work.preceding_works << self
  end
end
