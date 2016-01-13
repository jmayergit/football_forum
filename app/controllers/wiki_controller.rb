class WikiController < ApplicationController
  def index
    @renderer_toc = Redcarpet::Render::HTML_TOC.new()
    @markdown_toc = Redcarpet::Markdown.new(@renderer_toc)

    @renderer = Redcarpet::Render::HTML.new(filter_html: true)
    @markdown = Redcarpet::Markdown.new(@renderer, { superscript: true, underline: true, strikethrough: true, quote: true, highlight: true} )
  end
end
