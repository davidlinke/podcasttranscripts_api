class Mutations::RemovePodcastEpisode < Mutations::BaseMutation
    argument :episode_id, ID, required: true
     
    field :episode, Types::EpisodeType, null: false
    field :errors, [String], null: false
    field :removed, Boolean, null: false
  
    def resolve(episode_id:)
        foundEpisode = Episode.find(episode_id)
        
        if foundEpisode.delete
            {
                removed: true,
                episode: foundEpisode,
                errors: [],
            }
        else
            {
                removed: false,
                episode: nil,
                errors: episode.errors.full_messages
            }
        end
    end
end