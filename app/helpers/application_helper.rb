module ApplicationHelper
  def markdown(text)
    body = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
    body.html_safe
  end

  def all_users
    users = User.all
    users
  end
end
