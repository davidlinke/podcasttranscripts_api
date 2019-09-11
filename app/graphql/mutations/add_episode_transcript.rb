class Mutations::AddEpisodeTranscript < Mutations::BaseMutation
    argument :episode_id, ID, required: true
    argument :transcript, String, required: true
    argument :transcript_added_by_user_id, ID, required: true
     
    field :episode, Types::EpisodeType, null: false
    field :errors, [String], null: false
  
    def resolve(episode_id:, transcript:, transcript_added_by_user_id:)

        foundEpisode = Episode.find(episode_id)
        foundEpisode.update(
            transcript: transcript,
            transcript_added_by_user_id: transcript_added_by_user_id,
            transcript_added_date: Time.now
        )

        if foundEpisode.save
            {
                episode: foundEpisode,
                errors: [],
            }
        else
            {
                episode: nil,
                errors: episode.errors.full_messages
            }
        end
    end
end