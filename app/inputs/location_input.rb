class LocationInput < SimpleForm::Inputs::Base
  def input

    @picker_name = 'datetime_picker'
    @picker_format = "yyyy-MM-dd HH:mm PP"

    street_address = input_html_options[:value]
    if street_address.blank?
      method_value = object.try(attribute_name)
      street_address = template.l(method_value) if method_value # default value
    end

    #create the input

    location_input = @builder.text_field(attribute_name, { data: { format: @picker_format }, value: street_address, placeholder: 'Yonge St. and Dundas St.' }.merge(input_html_options))

    # add calendar button

    gps_icon = template.content_tag(:i, nil, { class: "icon-location-arrow" })
    gps_text = template.content_tag(:span, nil, { class: "gps-text" })
    gps_button = template.content_tag(:button, gps_icon + gps_text, { class: "btn get-location", type: "button", rel: 'tooltip', title: 'Get your current location' })

    template.content_tag(:div, location_input + gps_button, class: "input-append")
  end
end
