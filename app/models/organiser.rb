class Organiser
  include Her::JsonApi::Model
  include HasEvent

  use_api EVENTS_API
  collection_path "/api/organisers"

end
