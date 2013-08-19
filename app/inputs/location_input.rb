class LocationInput < SimpleForm::Inputs::Base
  def input
    street_address = input_html_options[:value]
    if street_address.blank?
      street_address = object.try(attribute_name)
    end

    #create the input

    location_input = @builder.text_field(attribute_name, { data: { format: 'string' }, value: street_address, placeholder: 'Yonge St. and Dundas St.' }.merge(input_html_options))

    # add calendar button

    gps_icon = template.content_tag(:i, nil, { class: "icon-location-arrow" })
    gps_text = template.content_tag(:span, nil, { class: "gps-text" })
    gps_button = template.content_tag(:button, gps_icon + gps_text, { class: "btn get-location", type: "button", rel: 'tooltip', title: 'Get your current location' })

    template.content_tag(:div, location_input + gps_button, class: "input-append")
  end
end
