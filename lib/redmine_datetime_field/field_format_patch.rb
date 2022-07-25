module RedmineDatetimeField
  module FieldFormatPatch
    class DateTimeFormat < Redmine::FieldFormat::Unbounded
      add "datetime"
      self.form_partial = "custom_fields/formats/datetime"

      def cast_single_value(custom_field, value, customized = nil)
        value.to_datetime rescue nil
      end

      def validate_single_value(custom_field, value, customized = nil)
        if /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.match?(value) && (value.to_date rescue false)
          []
        else
          [::I18n.t("not_a_datetime")]
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options = {})
        view.datetime_field_tag(tag_name, custom_value.value, options.merge(:id => tag_id, :size => 10))
      end

      def bulk_edit_tag(view, tag_id, tag_name, custom_field, objects, value, options = {})
        view.datetime_field_tag(tag_name, value, options.merge(:id => tag_id, :size => 10))
        bulk_clear_tag(view, tag_id, tag_name, custom_field, value)
      end

      def query_filter_options(custom_field, query)
        { :type => :datetime }
      end

      def group_statement(custom_field)
        order_statement(custom_field)
      end

      def formatted_value(view, custom_field, value, customized = nil, html = false)
        res = ""

        unless value.empty?
          res = DateTime.parse(value).strftime("%F %R")
        end

        if html
          if custom_field.url_pattern.present?
            super
          elsif custom_field.text_formatting == "full"
            view.textilizable(value, :object => customized)
          else
            res
          end
        else
          res
        end
      end
    end
  end
end
