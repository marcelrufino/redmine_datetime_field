curr_dirname = File.dirname(__FILE__)

%w(field_format_patch).each do |require_file|
  require File.join(curr_dirname, "lib", "redmine_datetime_field", require_file)
end

Redmine::Plugin.register :redmine_datetime_field do
  name "Date Time Custom Field plugin"
  author "Dmitry Migunov"
  description "DateTime custom field"
  version "0.0.1"

  Redmine::FieldFormat.__send__(:include, RedmineDatetimeField::FieldFormatPatch)
end
