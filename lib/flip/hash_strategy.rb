module Flip
  class HashStrategy < AbstractStrategy
    def description
      "Thread-local hash backed; applies to all users, useful for test environments only"
    end

    def knows? definition
      hash.key? key_name(definition)
    end

    def on? definition
      value_is_on? hash[key_name(definition)]
    end

    def switchable?
      true
    end

    def switch! definition, on
      hash[key_name(definition)] = set_value(on)
    end

    def delete! definition
      hash.delete key_name(definition)
    end

    private

    def key_name definition
      definition = definition.key unless definition.is_a? Symbol
      "flip_#{definition}"
    end

    def set_value on
      on ? "true" : "false"
    end

    def value_is_on? value
      value === "true"
    end

    def hash
      @hash ||= {}
    end
  end
end
