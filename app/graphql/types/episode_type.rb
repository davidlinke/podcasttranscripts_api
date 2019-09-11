module Types
  class EpisodeType < Types::BaseObject
    field :id, ID, null: true
    field :podcast_id, Integer, null: true
    field :title, String, null: true
    field :published_date, String, null: true
    field :image_url, String, null: true
    field :description, String, null: true
    field :audio_url, String, null: true
    field :duration, Integer, null: true
    field :transcript, String, null: true
    field :transcript_added_date, String, null: true
    field :transcript_added_by_user_id, Integer, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true
  end
end
