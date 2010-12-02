class Notifier < ActionMailer::Base
  def event_reg_confirmation(reg, event)
    subject       "Registration Confirmation - "+event.name
    from          "events@gschristian.org"
    recipients    reg.email
    sent_on       Time.now
    body          :event_url => root_url+"events/"+reg.id.to_s+"/reg_conf?pw="+reg.password, :event => event, :reg => reg
  end

  def payment_cleared(reg, event)
    subject       "Payment cleared for - "+event.name
    from          "events@gschristian.org"
    recipients    reg.email
    sent_on       Time.now
    body          :event_url => root_url+"events/"+reg.id.to_s+"/reg_conf?pw="+reg.password, :event => event, :reg => reg
  end

  def note_left(reg, event)
    subject       "A note is left for - "+event.name
    from          "events@gschristian.org"
    recipients    reg.email
    sent_on       Time.now
    body          :event_url => root_url+"events/"+reg.id.to_s+"/reg_conf?pw="+reg.password, :event => event, :reg => reg
  end

end
