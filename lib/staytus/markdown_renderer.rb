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

  end
end
