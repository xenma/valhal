module Administration
  # Model for containing sets of controlled vocabulary terms
  # for example Relator codes etc.
  class ControlledList < OhmModelWrapper
    attribute :name
    set :elements, Administration::ListEntry
  end
end