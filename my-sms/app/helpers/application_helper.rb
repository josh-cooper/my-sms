# frozen_string_literal: true

module ApplicationHelper
  # override link renderer in will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options = collection_or_options
      collection_or_options = nil
    end
    unless options[:renderer]
      options = options.merge renderer: BootstrapLinkRenderer
    end
    super *[collection_or_options, options].compact
  end

  ALERT_CLASS = {
    error: 'alert-danger',
    success: 'alert-success',
    alert: 'alert-warning',
    notice: 'alert-info'
  }.freeze
  ALERT_CLASS_DEFAULT = 'alert-primary'

  # auto assign bootstrap class depending on flash type
  def get_alert_class(flash_type)
    ALERT_CLASS.fetch(flash_type, ALERT_CLASS_DEFAULT)
  end

  # custom link renderer to add bootstrap styling to pagination links
  class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def page_number(page) # rubocop:disable Metrics/MethodLength
      current_number = page == current_page

      aria_label = @template.will_paginate_translate(
        :page_aria_label,
        page: page.to_i
      ) { "Page #{page}" }
      page_link = link(
        page,
        page,
        rel: rel_value(page),
        class: 'page-link',
        "aria-label": aria_label
      )
      tag(
        :li,
        page_link,
        class: "page-item#{' active' if current_number}",
        "aria-label": aria_label,
        "aria-current": current_number ? 'page' : nil
      )
    end

    # explicity assign pagination class to prevent breaking change
    def html_container(html)
      tag(:dive, html, container_attributes.merge(class: 'pagination'))
    end
  end
end
