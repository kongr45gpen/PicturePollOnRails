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

  # change the default link renderer for will_paginate
#   def will_paginate(collection_or_options = nil, options = {})
#     if collection_or_options.is_a? Hash
#       options, collection_or_options = collection_or_options, nil
#     end
#     unless options[:renderer]
#       options = options.merge :renderer => SemanticUIPagination::SemanticUIRenderer
#     end
#     super *[collection_or_options, options].compact
#   end
end

# A custom renderer class for WillPaginate that produces markup suitable for use with Semantic UI.
class WillPaginate::ActionView::LinkRenderer
  include SemanticUIPagination::SemanticUIRenderer
end
