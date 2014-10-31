# -*- encoding : utf-8 -*-

# Utility helper method containing generic utility methods, which should be usable across different classes, etc.
module UtilityHelper
  #Returns an array of String values, useful for populating drop-down menus
  #@param controlled_vocab_name String name of the controlled vocabulary whose values you want to use
  #@return [Array of Strings]
  def get_controlled_vocab(controlled_vocab_name)
    vocabulary = ControlledList.with(:name, controlled_vocab_name)
    vocabulary.nil? ? [] : vocabulary.entries.map { |e| e.name }
  end
end