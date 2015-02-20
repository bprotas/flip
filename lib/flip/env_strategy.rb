module Flip
  class EnvStrategy < AbstractStrategy
    def description
      "Environment-variable backed; applies to all users"
    end

    def knows? definition
      env.key? env_var_name(definition)
    end

    def on? definition
      env[env_var_name(definition)] === 'true'
    end

    def switchable?
      false
    end

    private

    def env
      ENV || {}
    end

    def env_var_name definition
      definition = definition.key unless definition.is_a? Symbol
      "flip_#{definition}"
    end
  end
end
