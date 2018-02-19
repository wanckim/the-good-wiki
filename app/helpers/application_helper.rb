module ApplicationHelper
  def markdown(text)
    body = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
    body.html_safe
  end
end
