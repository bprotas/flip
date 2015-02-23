module Flip
  class EnvStrategy < HashStrategy
    def switchable?
      false
    end

    def switch!(definition, on)
      raise
    end

    def delete! definition
      raise
    end

    private

    def key_name definition
      super.upcase
    end

    def hash
      ENV
    end
  end
end
