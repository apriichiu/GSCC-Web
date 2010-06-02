module EventsHelper
  def link_to_events( event )
    <<HTML
      <a href="#{url_for(event)}">
      <abbr class="dtstart" title="#{event.startdate}">#{event.startdate.strftime("%b %d / %I:%M %p")}</abbr>
      <div>#{event.title}</div>
      <div>@ #{event.location}</div></a>
     
HTML
  end
end
