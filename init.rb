curr_dirname = File.dirname(__FILE__)

%w(field_format_patch).each do |require_file|
  require File.join(curr_dirname, "lib", "redmine_datetime_field", require_file)
end

logger.info "**** PASSOU AQUI ****"
Query.operators_by_filter_type << :datetime => [ "=", ">=", "<=", "><", "<t+", ">t+", "><t+", "t+", "nd", "t", "ld", "nw", "w", "lw", "l2w", "nm", "m", "lm", "y", ">t-", "<t-", "><t-", "t-", "!*", "*" ]
logger.info "**** QUERY: #{query.operators_by_filter_type}"


Redmine::Plugin.register :redmine_datetime_field do
  name "Date Time Custom Field plugin"
  author "Dmitry Migunov"
  description "DateTime custom field"
  version "0.0.1"

  Redmine::FieldFormat.__send__(:include, RedmineDatetimeField::FieldFormatPatch)
end