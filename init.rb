curr_dirname = File.dirname(__FILE__)

Redmine::Plugin.register :redmine_datetime_field do
  name "Date Time Custom Field plugin"
  author "Dmitry Migunov"
  description "DateTime custom field"
  version "0.0.1"

  Redmine::FieldFormat.__send__(:include, RedmineDatetimeField::FieldFormatPatch)
  Redmine::Query.__send__(:include, RedmineDatetimeField::QueryPatch)

end

require "field_format_patch"
require "query_patch"