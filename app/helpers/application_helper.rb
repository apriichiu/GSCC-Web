# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_title
    page_title = @page_title || (params[:action] + '_' + params[:controller]).humanize
    return h(page_title)
  end

  def navigation_item(item)
    template = <<-eos
%li{:class => item.dasherize}
  %a{:href => section_path(item),
     :class => params[:section] == item ? 'selected' : ''}
    =item.humanize
    eos
    return render_to_string(:inline => template, :type => :haml, :locals => { :item => item})
  end

  def static_pages
    StaticPageController.pages
  end

  def li_link_to(*args)
    "<li>#{link_to(*args)}</li>"
  end

  def recent_events
    EventsController.recent_events
  end

end

