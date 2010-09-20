# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_title
    page_title = @page_title || (params[:action] + '_' + params[:controller]).humanize
    return h(page_title)
  end

  def navigation_item(item)
    #Added a quick hack so the events tab would also be selected
    #The problem is that events isn't part of the static pages, so the
    #params[:section] won't be filled with events. So i added a
    #function that sets the variable @in_events in the before_filter
    #list of the events controller, so whenever we're in the events
    #controller the events navigation item will be selected - ILIU

    ##Added the same hack for resources

    template = <<-eos
%li{:class => item.dasherize}
  %a{:href => section_path(item),
     :class => params[:section] == item || (item =="events" && @in_events) || (item =="resources" && @in_resources) ? 'selected' : ''}
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

end

