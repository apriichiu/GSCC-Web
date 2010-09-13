module EventsHelper
  def upcoming_events_block( event )
    <<HTML
      <div class="upcoming-events-item">
           <div class ="upcoming-events-icon">
             <p><strong>#{event.start_time.day}</strong><span>#{event.start_time.strftime("%b")}</span></p>
           </div>
         <div class="upcoming-events-text">
      #{facebook_event_link(event.identifier, event.name)}
      <div>#{event.start_time.getlocal.strftime("%a, %I:%M%p")}</div>
      <div><b>@</b> #{event.location}</div>
          </div>
      </div>     
HTML
  end

  def facebook_event_link ( eid, text )
    <<HTML
      <a href="http://www.facebook.com/event.php?eid=#{eid}">#{text}</a>
HTML
  end

  def event_list_block (event)
    <<-HTML
  <div class="event_item_wrap">
  <div class="event_item">
    <p class="event_date_top">
         <strong>#{event.start_time.getlocal.strftime("%A, %B %d")}</strong>
    </p>
    <div class="event_image"> 
      #{image_tag(event.picture, :size => "80x80")}
    </div>
    <div class="event_info">
      <div class="event_title">
        #{facebook_event_link event.identifier, event.name}
      </div>
      <div class="event_time_location">
        <table><tr>
        <th><strong>When:</strong></th><td> <span class="event_time">#{get_short_time(event.start_time.getlocal, event.end_time.getlocal)}</span></td>
        </tr>
        <tr>
        <th><strong>Where:</strong></th><td> <span class="event_location">#{event.location}</span></td>
        </tr>
        </table>
      </div>
     </div>
  </div>
  <div class="event_item_space"></div>
  </div>
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
