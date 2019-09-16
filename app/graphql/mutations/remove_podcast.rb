class Mutations::RemovePodcast < Mutations::BaseMutation
    argument :podcast_id, ID, required: true
     
    field :podcast, Types::PodcastType, null: false
    field :errors, [String], null: false
    field :removed, Boolean, null: false
  
    def resolve(podcast_id:)
        foundPodcast = Podcast.find(podcast_id)
        
        if foundPodcast.delete
            {
                removed: true,
                podcast: foundPodcast,
                errors: [],
            }
        else
            {
                removed: false,
                podcast: nil,
                errors: podcast.errors.full_messages
            }
        end
    end
end