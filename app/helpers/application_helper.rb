# View helpers that are shared between different models
module ApplicationHelper
  # Gets the list of a controlled list
  # @param name of a controlled list
  def get_controlled_vocab(list_name)
    list = Administration::ControlledList.with(:name, list_name)
    list.nil? ? [] : list.elements.map(&:name)
  end

  # Given a list name, return a list of arrays
  # suitable for dropdowns, whereby the display
  # string value is translated via i18n
  def get_translated_list(list_name)
    list = get_controlled_vocab(list_name)
    list.map{ |e| [I18n.t("#{list_name}.#{e}".to_sym), e]}
  end

  # Renders a title type ahead field
  def render_title_typeahead_field
    results = Work.get_title_typeahead_objs
    select_tag 'work[titles][][value]', options_for_select(results.map { |result| collect_title(result['title_tesim'],result['id']) }.flatten(1)),
               { include_blank: true, class: 'combobox form-control input-large', data_function: 'title-selected' }
  end

  private

  def collect_title(titles,id)
    titles.collect {|title| [title,id]}
  end
end
