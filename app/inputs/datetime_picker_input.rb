class DatetimePickerInput < SimpleForm::Inputs::Base
  def input

    @picker_name = 'datetime_picker'
    @picker_format = "yyyy-MM-dd HH:mm PP"

    timestamp = input_html_options[:value]
    if timestamp.blank?
      method_value = object.try(attribute_name)
      timestamp = template.l(method_value) if method_value # default value
    end

    #create the input

    datetime_input = @builder.text_field(attribute_name, { data: { format: @picker_format }, value: timestamp, placeholder: 'yyyy-mm-dd hh:mm AM/PM' }.merge(input_html_options))

    # add calendar button

    calendar_icon = template.content_tag(:i, nil, {  class: "icon-calendar", data: { :"time-icon" => "icon-time", :"date-icon" => "icon-calendar"} })
    calendar_button = template.content_tag(:button, calendar_icon + ' Set time & date', { class: "btn", type: "button" })

    template.content_tag(:div, datetime_input + calendar_button , data: { behaviour: @picker_name }, class: "input-append date")
  end
end