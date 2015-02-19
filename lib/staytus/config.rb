module Staytus
  module Config
    class << self

      def theme_root
        Rails.root.join('content', 'themes', ENV['STAYTUS_THEME'] || 'default')
      end

    end
  end
end
