module ApplicationHelper

  def markdown(text)
    # options = { hard_wrap: true, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode }
    # markdown = Redcarpet::Markdown.new(autolink: true, fenced_code: true, filter_html: true, gh_blockcode: true ).to_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, no_intra_emphasis: true, footnotes: true, highlight: true )
    html = markdown.render(text)
    syntax_highlighter(html.html_safe)
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end


  def title(text)
    content_for(:title, "#{text}" ) if text.present?
  end

  def content(text)
    content_for(:content, "#{text}" ) if text.present?
  end


  def an_or_a(text)
    if text == "comment"
      return 'a'
    else
      return 'an'
    end
  end






  def semantic_flash(flash_type)
    {
      :success => 'success',
      :error => 'negative',
      :alert => 'warning',
      :notice => 'info'
    }[flash_type.to_sym] || flash_type.to_s
  end
end
