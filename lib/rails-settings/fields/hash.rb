module RailsSettings
  module Fields
    class Hash < ::RailsSettings::Fields::Base
      def convert_to_value(value)
        return value unless value.is_a?(::String)

        load_value(value).deep_stringify_keys.with_indifferent_access
      end

      def load_value(value)
        YAML.safe_load(value).to_h
      rescue StandardError
        {}
      end
    end
  end
end
