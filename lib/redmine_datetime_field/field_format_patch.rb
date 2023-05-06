module RedmineDatetimeField
  module FieldFormatPatch
    class DateTimeFormat < Redmine::FieldFormat::Unbounded
      add "datetime"
      self.form_partial = "custom_fields/formats/datetime"

      def cast_single_value(custom_field, value, customized = nil)
        value.to_datetime rescue nil
      end

      def validate_single_value(custom_field, value, customized = nil)
        valid_datetime = DateTime.parse value rescue false
        if valid_datetime
          []
        else
          [::I18n.t("not_a_datetime")]
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options = {})
        view.datetime_field_tag(tag_name, DateTime.parse(custom_value.value).strftime("%Y-%m-%dT%H:%M"), options.merge(:id => tag_id, :size => 10))
      end

      def bulk_edit_tag(view, tag_id, tag_name, custom_field, objects, value, options = {})
        view.datetime_field_tag(tag_name, value, options.merge(:id => tag_id, :size => 10))
        bulk_clear_tag(view, tag_id, tag_name, custom_field, value)
      end

      def query_filter_options(custom_field, query)
        logger.info "**** PASSOU AQUI ****"
        query.add_available_filter("datetime", [ "=", ">=", "<=", "><", "<t+", ">t+", "><t+", "t+", "nd", "t", "ld", "nw", "w", "lw", "l2w", "nm", "m", "lm", "y", ">t-", "<t-", "><t-", "t-", "!*", "*" ])
        logger.info "**** QUERY: #{query.operators_by_filter_type}"
        { :type => :datetime }
      end

      def group_statement(custom_field)
        order_statement(custom_field)
      end

      def formatted_value(view, custom_field, value, customized = nil, html = false)
        res = ""

        unless !value || value.empty?
          res = DateTime.parse(value).strftime("%d/%m/%Y %H:%M")
        end

        if html
          if custom_field.url_pattern.present?
            super
          elsif custom_field.text_formatting == "full"
            view.textilizable("#{value}C", :object => customized)
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
