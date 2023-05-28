module RailsSettings
  module Fields
    class Array < ::RailsSettings::Fields::Base
      def convert_to_value(value)
        return value unless value.is_a?(::String)

        value.split(separator).reject(&:empty?).map(&:strip)
      end
    end
  end
end
