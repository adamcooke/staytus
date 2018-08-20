module Staytus
  class Webhook

    class << self

      #
      # Send an email to the given recipient
      #
      def call(attributes = {})
        puts "Webhook"
        puts attributes.issue.to_json

      end

    end
  end
end
