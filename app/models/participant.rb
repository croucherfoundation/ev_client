class Participant
  include Her::JsonApi::Model
  include HasEvent

  use_api EVENTS_API
  collection_path "/api/participants"

end
