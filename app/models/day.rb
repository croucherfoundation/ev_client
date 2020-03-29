class Day
  include Her::JsonApi::Model
  include HasEvent

  use_api EVENTS_API
  collection_path "/api/days"

  def datetime
    DateTime.parse(date) if date?
  end
  
  def time
    datetime.time_of_day if datetime?
  end

end
