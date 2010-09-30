module EventsHelper
  def upcoming_events_block( event )
    <<HTML
      <table class="upcoming-events-item">
          <tr>
           <td class ="upcoming-events-icon">
             <p><strong>#{event.start_time.day}</strong><span>#{event.start_time.strftime("%b")}</span></p>
           </td>
            <td>
         <div class="upcoming-events-text">
      #{facebook_event_link(event.identifier, event.name)}
      <div>#{event.start_time.getlocal.strftime("%a, %I:%M%p")}</div>
      <div><b>@</b> #{event.location}</div>
          </td>
      </tr>
     </table>     
HTML
  end

  def facebook_event_link ( eid, text )
    <<HTML
      <a href="http://www.facebook.com/event.php?eid=#{eid}">#{text}</a>
HTML
  end

  def event_list_block (event)
    <<-HTML
     <table cellpadding="0" cellspacing="0" border="0">
       <tr>
         <th class="ui-widget-header ui-corner-top">
           #{event.start_time.getlocal.strftime("%A, %B %d, %Y")}
         </th>
       </tr>
       <tr>
         <td class="ui-state-default ui-corner-bottom">
        <table class="event_time_location" cellpadding="0" cellspacing="0">
        <tr>
            <td rowspan="4" width="85px">#{image_tag(event.picture, :size => "80x80")}</td>
            <th colspan="2"><span class="event_title">#{facebook_event_link event.identifier, event.name}</span></th>
        </tr>
        <tr>
        <td><strong>When:</strong></td><td> <span class="event_time">#{get_short_time(event.start_time.getlocal, event.end_time.getlocal)}</span></td>
        </tr>
        <tr>
        <td><strong>Where:</strong></td><td> <span class="event_location">#{event.location}</span></td>
        </tr>
        <tr>
        <td>&nbsp;</td><td></td>
        </tr>

        </table>
         </td>
       </tr>
     </table>
HTML
  end 

  def get_short_time(start_time, end_time)
    output = start_time.strftime("%A, %B %d");
    output += " from ";
    output += start_time.strftime("%I:%M %p");
    output += " to ";
    if start_time.strftime("%B %d") != end_time.strftime("%B %d")
      output += end_time.strftime("%A, %B %d");
      output += " ";
    end
    output += end_time.strftime("%I:%M %p");
    return output;
  end
end
