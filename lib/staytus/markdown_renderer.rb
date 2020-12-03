require 'redcarpet'
require 'rouge'

module Staytus
  class MarkdownRenderer < Redcarpet::Render::HTML

    def block_code(code, language)
      title = nil
      code.gsub!(/\A@title:\s*([\w\s:+]+)\n/m) do
        title = Regexp.last_match(1)
        ''
      end

      lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText
      formatter = Rouge::Formatters::HTMLLegacy.new(css_class: "highlight #{lexer.tag}")
      code = formatter.format(lexer.lex(code))

      if title
        code = "<p class='codeTitle'>#{title}</p>" + code
      end
      code
    end

    def image(link, title, alt_text)
      # Get classes out of the ALT text
      alt_text, classes, title = (alt_text || '').split('*').map(&:strip)

      # Return our image tag
      img = "<img src='#{link}' alt='#{alt_text}' title='#{title}' class='#{classes}' />"
      if title
        "#{img}<span class='imageCaption #{classes}'>#{title}</span>"
      else
        img
      end
    end

    def link(link, title, content)
      if link =~ /\A\//
        link = "#{Home.web_host_with_protocol}#{link}"
      end
      "<a href='#{link}' title='#{title}'>#{content}</a>"
    end

    def paragraph(text)
      class_name = nil
      text.gsub!(/\A@([a-z\- ]+):\s*/i) do
        class_name = Regexp.last_match(1)
        ''
      end
      text.gsub!(/\R+/, '<br />') if @options[:hard_wrap]
      "<p class='#{class_name}'>#{text}</p>"
    end

  end
end
