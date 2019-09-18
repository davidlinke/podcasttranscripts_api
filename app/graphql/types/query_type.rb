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

    field :episodes, [Types::EpisodeType], null:false do
      argument :podcast_id, ID, required: true
      argument :transcript_filter, String, required: false
    end

    def episodes(podcast_id:, transcript_filter:)

      def escape_search_term(term)
        "%#{term.gsub(/\s+/, '%')}%"
      end

      eps = Episode.where(podcast_id: podcast_id)

      if transcript_filter != "" then
        eps = eps.where(["LOWER(transcript) LIKE LOWER(?)", escape_search_term(transcript_filter)])
      end
      
      eps
    end
    
  end
end
