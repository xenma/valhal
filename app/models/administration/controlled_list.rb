module Administration
  # Model for containing sets of controlled vocabulary terms
  # for example Relator codes etc.
  class ControlledList < OhmModelWrapper
    attribute :name
    unique :name
    collection :elements, Administration::ListEntry

    def elements=(elements)
      self.save unless self.persisted?
      elements.each do |new|
        values = params_to_hash(new)
        if values.key?(:id) && values[:id].present?
          entry = Administration::ListEntry[values[:id]]
          values.merge!(controlled_list_id: self.id)
          entry.update(values)
        elsif values.key?(:name) && values[:name].present?
          values[:controlled_list_id] = self.id
          entry = Administration::ListEntry.new(values)
        end
        entry.save if defined?(entry) and entry
      end
      save
    end
# convert a hash with string keys
# to one with symbol keys
    def params_to_hash(params)
      symboled = {}
      params.each{ |k,v| symboled[k.to_sym] = v }
      symboled
    end
  end
end