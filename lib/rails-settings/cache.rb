module RailsSettings
  module Cache
    extend self

    def set_prefix(&block)
      @prefix = block
    end

    def key
      key_parts = ["rails-settings-cached"]
      key_parts << @prefix.call if @prefix
      key_parts.join("/")
    end

    def clear
      request_cache.reset
      rails_cache.delete(key)
    end

    def settings(parent)
      request_cache.all_settings ||= rails_cache.fetch(key, expires_in: 1.week) do
        vars = parent.unscoped.select("var, value")
        result = {}
        vars.each { |record| result[record.var] = record.value }
        result.with_indifferent_access
      end
    end

    private

    def request_cache
      ::RailsSettings::RequestCache
    end

    def rails_cache
      ::Rails.cache
    end
  end
end
