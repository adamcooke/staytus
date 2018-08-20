module Staytus
  class Webhook

    class << self

      #
      # Send an email to the given recipient
      #
      def call(attributes = {})
        logger.info "Webhook"
        logger.info attributes.issue.to_json

      end

    end
  end
end
