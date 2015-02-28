module Staytus
  class Email

    class << self

      #
      # Send an email to the given recipient
      #
      def deliver(recipient, template, attributes = {})
        mail = Mail.new
        mail.to         recipient
        mail.from       "#{from_name} <#{from_address}>"
        mail.subject    self.subject_for(template, attributes)
        plain_text = self.body_for(template, attributes)
        mail.text_part do
          body plain_text
        end


        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        content_html = markdown.render(plain_text)

        template_html = File.read(File.join(Staytus::Config.theme_root, 'views', 'email.html'))
        final_html = Florrick.convert(template_html, add_default_attributes(:content => content_html))
        premailer = Premailer.new(final_html, :with_html_string => true)
        final_html = premailer.to_inline_css

        mail.html_part do
          body final_html
        end

        mail.deliver
        mail
      end

      #
      # Generate the contents of the message which should be sent.
      #
      def body_for(template, attributes = {})
        if raw_template = default_template(template)
          Florrick.convert(raw_template, add_default_attributes(attributes))
        end
      end

      #
      # Generate a subject for a given template
      #
      def subject_for(template, attributes = {})
        if value = I18n.t("default_email_subjects.#{template}")
          Florrick.convert(value, add_default_attributes(attributes))
        else
          "No Subject"
        end
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
