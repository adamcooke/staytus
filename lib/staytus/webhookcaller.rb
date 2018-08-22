module Staytus
  class Webhookcaller

    class << self

      #
      # Send an Data to a webhook
      #
      def call(type, attributes = {})


        # Get Detail data and add staytus_type to identify the Event
        data = attributes[:detail].as_json

        message = {}
        message["type"] = type

        # Empty if type is not available
        message_data = {}

        if ['issue_new'].include? type
          # Get Issue which was updated
          issue =  attributes[:detail].as_json
          issue["services"] = []

          # Add all affected services and the Service Status
          issueJoins = IssueServiceJoin.where(issue_id: issue["id"])
          issueJoins.all.each do |issueJoin|
            service = Service.find(issueJoin[:service_id]).as_json

            # Join Service Status for human readable text
            service_status = ServiceStatus.find(service["status_id"]).as_json
            service["status"] = service_status

            issue["services"].push(service)



          end

          # Add last Update
          issueupdate = IssueUpdate.where(id: data["id"]).last.as_json
          issue["updates"] = issueupdate

          message_data = issue
        end

        if ['issue_update'].include? type

          # Get Issue which was updated
          issue =  Issue.find(data["issue_id"]).as_json
          issue["services"] = []

          # Add all affected services and the Service Status
          issueJoins = IssueServiceJoin.where(issue_id: data["issue_id"])
          issueJoins.all.each do |issueJoin|
            service = Service.find(issueJoin[:service_id]).as_json

            # Join Service Status for human readable text
            service_status = ServiceStatus.find(service["status_id"]).as_json
            service["status"] = service_status

            issue["services"].push(service)

          end

          # Add last Update
          issueupdate = IssueUpdate.where(id: data["id"]).last.as_json
          issue["updates"] = issueupdate

          message_data = issue

        end

        message["data"] = message_data

        Webhook.all.each do |webhook|

          puts "Call Webhook " + webhook.name + " with URL: " + webhook.url

          header = {'Content-Type': 'application/json'}

          uri = URI(webhook.url)

          # Create the HTTP objects
          http = Net::HTTP.new(uri.host, uri.port)
          if uri.scheme == "https"
            http.use_ssl = true
          end
          request = Net::HTTP::Post.new(uri.request_uri, header)

          request.body = message.to_json

          # Send the request
          begin
            response = http.request(request)
          rescue StandardError
            # Ignore if failed!
          end

        end
      end # call

    end
  end
end
