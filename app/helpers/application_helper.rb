module ApplicationHelper
    def get_controlled_vocab(controlled_vocab_name)
     vocabulary = Administration::ControlledList.with(:name, controlled_vocab_name)
     vocabulary.nil? ? [] : vocabulary.elements.map { |e| e.name }
    end
end
