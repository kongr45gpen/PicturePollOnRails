require "semantic_ui_pagination/semantic_ui_renderer"

module ApplicationHelper
  def full_title(page_title)
    base_title = "Picture Poll"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end

# A custom renderer class for WillPaginate that produces markup suitable for use with Semantic UI.
class WillPaginate::ActionView::LinkRenderer
  include SemanticUIPagination::SemanticUIRenderer
end
