module ApplicationHelper

 def markdown(body)
  @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true,  hard_wrap: true, filter_html: true, no_intraemphasis: true, fenced_code: true, gh_blockcode: true, fenced_code_blocks: true)
  @markdown.render(body)
end
  

  def title(text)
    content_for(:title, "#{text}  " ) if text.present?
  end

 def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end



  def flash_class(level)
    case level
      when :notice then "alert alert-success"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-danger"
    end
  end
end


