class Party < ActiveRecord::Base
  has_many :people
  scope :attending, -> { joins(:people).where("people.attending = TRUE").group("parties.id") }
  scope :rsvped, -> { where(rsvp: true) }
  scope :viewed, -> { where("viewed_at IS NOT NULL")}
  scope :norsvp, -> { where(rsvp: nil)}

  def rsvp_by
    read_attribute(:rsvp_by).strftime("%B %e, %Y")
  end

  def rsvp_passed
    # Without the + 1.day bit, it cuts off at midnight, which seems harsh :)
    # We're also adding 4 hours because we are in the eastern time zone,
    # but the server is UTC. This will work for us, in the summer, but it's
    # kind of a hack.
    read_attribute(:rsvp_by) + 1.day + 4.hours < DateTime.now
  end

  def viewed_at=(value)
    if read_attribute(:viewed_at).nil?
      write_attribute(:viewed_at, value)
    end
  end

  def number_attending
    self.people.attending.count
  end
end
