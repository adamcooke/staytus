require 'staytus/version'

module Staytus
  module Config
    class << self

      def theme_root
        Rails.root.join('content', 'themes', ENV['STAYTUS_THEME'] || 'default')
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
