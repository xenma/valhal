# Custom input to enable use for multiple fields
class MultipleInput < SimpleForm::Inputs::Base
  # Create one or more input fields for a multiple valued attribute
  # including one empty input for adding new values.
  def input(_wrapper_options = {})
    result = ''
    # make sure the name is for a multi-valued parameter
    input_html_options.merge!(name: "#{object.class.downcase}[#{attribute_name}][]")
    if object.respond_to? attribute_name
      value = object.send(attribute_name)
      if value.is_a? Enumerable
        # create an input for each existing value
        value.each do |val|
          input_html_options.merge!(value: val)
          result += "#{@builder.text_field(attribute_name, input_html_options)}".html_safe
        end
      end
    end
    # Create a blank input for new values
    input_html_options.merge!(value: '')
    (result + "#{@builder.text_field(attribute_name, input_html_options)}").html_safe
  end
end
