class Event
  include Her::JsonApi::Model

  has_many :organisers
  has_many :participants
  has_many :images
  has_many :days

  use_api EVENTS_API
  collection_path "/api/events"

  # temporary while we are not yet sending jsonapi data back to core properly
  include_root_in_json true
  parse_root_in_json false

  def datetime
    DateTime.parse(date) if date?
  end
  
  def organised_by?(user)
    organisers.map(&:user_uid).include?(user.uid)
  end

  def participated_in_by?(user)
    participants.map(&:user_uid).include?(user.uid)
  end

end
