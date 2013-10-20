module ApplicationHelper
  def navbar_link(text, link, link_options: {})
    content_tag :li, :class => current_page?(link) ? "active" : "" do
      link_to text, link, link_options
      #"<li <% if current_page? users_path %><%= 'class=active'%><% end %>>"
    end
  end
end
