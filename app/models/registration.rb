class Registration < ActiveRecord::Base

  def deliver_confirmation
    @event = FacebookEvent.find(self.event_id);
    Notifier.deliver_event_reg_confirmation(self, @event)
  end

  def deliver_payment
    @event = FacebookEvent.find(self.event_id);
    Notifier.deliver_payment_cleared(self, @event)
  end

  def deliver_note
    @event = FacebookEvent.find(self.event_id);
    Notifier.deliver_note_left(self, @event)
  end

end
