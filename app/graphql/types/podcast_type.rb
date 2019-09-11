module Types
  class PodcastType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :rss_url, String, null: true
    field :web_url, String, null: true
    field :description, String, null: true
    field :image_url, String, null: true
    field :last_updated, String, null: true
    field :added_by_user, Integer, null: true
    field :premium_podcast, Boolean, null: true
    field :ignore_keywords, String, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true
    field :episodes, [EpisodeType], null: true do
      argument :id, ID, required: false
    end
  end
end

def episodes(id:)
  Episode.where(podcast_id: id)
end