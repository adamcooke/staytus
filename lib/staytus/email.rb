module Staytus
  class Email

    class << self

      #
      # Send an email to the given recipient
      #
      def deliver(subscriber, template, attributes = {})
        original_zone = Time.zone
        Time.zone = Site.first.time_zone
        mail = Mail.new
        mail.to         subscriber.email_address
        mail.from       "#{from_name} <#{from_address}>"
        mail.subject    self.subject_for(template, attributes.merge(:subscriber => subscriber))

        # Generate and set the plain text version of this message
        plain_text = self.body_for(template, attributes.merge(:subscriber => subscriber))
        mail.text_part do
          body plain_text
        end

        # Convert the plain text message into HTML
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        content_html = markdown.render(plain_text)

        # Get the HTML template and generate a final HTML message
        template_html = File.read(File.join(Staytus::Config.theme_root, 'views', 'email.html'))
        final_html = Florrick.convert(template_html, add_default_attributes(:content => content_html).merge(:subscriber => subscriber))

        # Pass the HTML through premailer to add inline CSS
        premailer = Premailer.new(final_html, :with_html_string => true)
        final_html = premailer.to_inline_css

        # Add the final html to the message
        mail.html_part do
          body final_html
        end

        mail.deliver
        mail
      ensure
        Time.zone = original_zone
      end

      #
      # Generate the contents of the message which should be sent.
      #
      def body_for(template_name, attributes = {})
        template = EmailTemplate.body_for(template_name)
        template = default_template(template_name) if template.nil?
        Florrick.convert(template, add_default_attributes(attributes))
      end

      #
      # Generate a subject for a given template
      #
      def subject_for(template, attributes = {})
        subject = EmailTemplate.subject_for(template)
        subject = I18n.t("email_templates.#{template}.default_subject") if subject.nil?
        subject = "No Subject" if subject.nil?
        Florrick.convert(subject, add_default_attributes(attributes))
      end

      #
      # Attributes with defaults
      #
      def add_default_attributes(attributes)
        attributes.merge({
          :site => site,
          :from_name => from_name,
          :from_address => from_address
        })
      end

      #
      # Return the name that emails should be sent from
      #
      def from_name
        site.email_from_name || site.title
      end

      #
      # Return the email address which e-mails should be sent from
      #
      def from_address
        site.email_from_address || site.support_email
      end

      #
      # Return the site
      #
      def site
        @site ||= Site.first
      end

      #
      # Return the default templtae content
      #
      def default_template(name)
        path = Rails.root.join('app', 'views', 'emails', "#{name}.txt")
        if File.exist?(path)
          File.read(path)
        else
          nil
        end
      end

    end
  end
end
