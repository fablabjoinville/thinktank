ActiveadminAddons.setup do |config|
  # Change to "default" if you want to use ActiveAdmin's default select control.
  # config.default_select = "default"

  # Set default options for DateTimePickerInput. The options you can provide are the same as in
  # xdan's datetimepicker library (https://github.com/xdan/datetimepicker/tree/2.5.4). Yo need to
  # pass a ruby hash, avoid camelCase keys. For example: use min_date instead of minDate key.
  # config.datetime_picker_default_options = {}

  config.datetime_picker_default_options = {
    format: "d/m/Y H:M",
    step: 30 # minutes
  }

  # Set DateTimePickerInput input format. This if for backend (Ruby)
  config.datetime_picker_input_format = "%d/%m/%Y %H:%M"
end
