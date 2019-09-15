module Types
  class QueryType < Types::BaseObject

    # USERS
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end
    
    def user(id:)
      User.find(id)
    end


    # PODCASTS
    field :podcasts, [Types::PodcastType], null: false

    def podcasts
      Podcast.all
    end

    field :podcast, Types::PodcastType, null: false do
      argument :id, ID, required: true
    end

    def podcast(id:)
      Podcast.find(id)
    end

    # EPISODES
    field :episode, Types::EpisodeType, null:false do
      argument :id, ID, required: true
    end

    def episode(id:)
      Episode.find(id)
    end

  end
end
