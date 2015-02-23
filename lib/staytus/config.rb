require 'staytus/version'

module Staytus
  module Config
    class << self

      def theme_name
        ENV['STAYTUS_THEME'] || 'default'
      end

      def theme_root
        Rails.root.join('content', 'themes', self.theme_name)
      end

      def version
        Staytus::VERSION
      end

      def demo?
        ENV['STAYTUS_DEMO'] == '1'
      end

    end
  end
end
