module Soyuz
  module Support

    private

    def symbolize_keys(objekt)
      return objekt unless objekt.is_a?(Hash)
      objekt.inject({}) do |result, (key, value)|
        new_key   = key.to_sym rescue key
        new_value = case value
                    when Hash then symbolize_keys(value)
                    when Array then value.map{|el| symbolize_keys(el) }
                    else value
                    end
        result[new_key] = new_value
        result
      end
    end
  end
end
