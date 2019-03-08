module Staytus
  class Webhookcaller

    class << self
      #
      # Send a message to a webhook
      #
      def call(type, attributes = {})
        # Get details about caller and update object
        object = attributes[:object]
        update = attributes[:update]
        message = { "type" =>  type, "data" => {} }

        # Add Maintenance/Issue related data to the message
        if object.is_a? Issue or object.is_a? Maintenance
          data =  object.as_json
          data["class"] = object.class.to_s
          data["services"] = object.services.map do |service|
            service.as_json.merge( "status" => service.status.as_json )
          end
          data["text"] = update ? update.text : object.description
          # Add a URL reference
          data["url"] = "#{Site.first.domain_with_protocol}/#{object.class.to_s.downcase}/#{object.identifier}"
          message["data"] = data
        end

        if object.is_a? Maintenance
          message["data"]["state"] = object.status.to_s
        end

        Webhook.all.each do |webhook|
          puts "Call Webhook #{webhook.name} with URL: #{webhook.url}"
          header = {"Content-Type" => "application/json"}
          uri = URI(webhook.url)

          # Create the HTTP objects
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == "https"

          request = Net::HTTP::Post.new(uri.request_uri, header)
          request.body = message.to_json

          # Send the request
          begin
            http.request(request)
          rescue => e
            puts "Error calling webhook: #{e.message}"
          end
        end
      end # call

    end
  end
end
