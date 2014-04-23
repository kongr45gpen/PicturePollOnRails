# Source: https://github.com/bootstrap-ruby/will_paginate-bootstrap
#
# Copyright (c) 2012 Nicholas Dainty
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module SemanticUIPagination
  # Contains functionality shared by all renderer classes.
  module SemanticUIRenderer
    ELLIPSIS = "&hellip;"

    def to_html
      list_items = pagination.map do |item|
        case item
        when Fixnum
          page_number(item)
        else
          send(item)
        end
      end.join(@options[:link_separator])

      tag("div", list_items, class: ul_class)
    end

    def container_attributes
      super.except(*[:link_options])
    end

    protected

    def page_number(page)
      link_options = @options[:link_options] || {class: "item"}

      if page == current_page
        tag("span", page, class: "active item")
      else
        link(page, page, link_options.merge(rel: rel_value(page)))
      end
    end

    def previous_or_next_page(page, text, classname)
      link_options = @options[:link_options] || {class: classname}

      if page
        link(text, page, link_options)
      else
        tag("span", text, class: "%s disabled" % classname)
      end
    end

    def gap
      tag("span", ELLIPSIS, class: "disabled item")
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, "<i class='left arrow icon'></i>", "prev icon item")
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page(num, "<i class='right arrow icon'></i>", "next icon item")
    end

    def ul_class
      if @options[:class] == "pagination"
        @options[:class] + " ui inverted menu"
      else @options[:class]
      end
    end
  end
end
