class Mutations::EditPodcastEpisode < Mutations::BaseMutation
    argument :episode_id, ID, required: true
    argument :podcast_id, ID, required: true
    argument :title, String, required: true
    argument :published_date, String, required: true
    argument :description, String, required: true
    argument :audio_url, String, required: true
    argument :duration, Integer, required: true
    argument :episode_added_by_user_id, ID, required: true
    argument :transcript, String, required: false

    field :episode, Types::EpisodeType, null: false
    field :errors, [String], null: false
    field :updated, Boolean, null: false
  
    def resolve(episode_id:, podcast_id:, title:, published_date:, description:, audio_url:, duration:, episode_added_by_user_id:, transcript:)
        foundEpisode = Episode.find(episode_id)

        # IF NO TRANSCRIPT UPDATE WITHOUT ONE
        if transcript.nil?
            foundEpisode.update(title: title, podcast_id: podcast_id, published_date: published_date, description: description, audio_url: audio_url, duration: duration, episode_added_by_user_id: episode_added_by_user_id, transcript: null, transcript_added_date: null, transcript_added_by_user_id: null)
        # IF TRANSCRIPT IN UPDATE, ADD IT
        else
            foundEpisode.update(title: title, podcast_id: podcast_id, published_date: published_date, description: description, audio_url: audio_url, duration: duration, episode_added_by_user_id: episode_added_by_user_id, transcript: transcript, transcript_added_date: Time.now, transcript_added_by_user_id: episode_added_by_user_id)
        end

        if foundEpisode.save
            {
                updated: true,
                episode: foundEpisode,
                errors: [],
            }
        else
            {
                updated: false,
                episode: nil,
                errors: episode.errors.full_messages
            }
        end
    end
end



# t.string :transcript
# t.timestamp :transcript_added_date
# t.integer :transcript_added_by_user_id