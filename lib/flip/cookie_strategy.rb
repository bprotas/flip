# Uses cookie to determine feature state.
module Flip
  class CookieStrategy < HashStrategy

    def description
      "Uses cookies to apply only to your session."
    end

    def self.cookies= cookies
      @hash = cookies
    end

    def cookie_name definition
      key_name definition
    end

    def self.hash
      @hash
    end

    def hash
      self.class.hash || {}
    end

    private

    def set_value on
      {
        'value' => (on ? "true" : "false"),
        'domain' => :all
      }
    end

    def value_is_on? value
      check = value.is_a?(Hash) ? value['value'] : value
      super(check)
    end

    # Include in ApplicationController to push cookies into CookieStrategy.
    # Users before_filter and after_filter rather than around_filter to
    # avoid pointlessly adding to stack depth.
    module Loader
      extend ActiveSupport::Concern
      included do
        before_filter :flip_cookie_strategy_before
        after_filter :flip_cookie_strategy_after
      end
      def flip_cookie_strategy_before
        CookieStrategy.cookies = cookies
      end
      def flip_cookie_strategy_after
        CookieStrategy.cookies = nil
      end
    end

  end
end
