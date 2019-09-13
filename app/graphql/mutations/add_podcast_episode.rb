class Mutations::AddPodcastEpisode < Mutations::BaseMutation
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
  
    def resolve(podcast_id:, title:, published_date:, description:, audio_url:, duration:, episode_added_by_user_id:, transcript:)

        if transcript.nil?
            episode = Episode.new(
                podcast_id: podcast_id,
                title: title,
                published_date: published_date,
                description: description,
                audio_url: audio_url,
                duration: duration,
                episode_added_by_user_id: episode_added_by_user_id
            )
        else
            episode = Episode.new(
                podcast_id: podcast_id,
                title: title,
                published_date: published_date,
                description: description,
                audio_url: audio_url,
                duration: duration,
                episode_added_by_user_id: episode_added_by_user_id,
                transcript: transcript,
                transcript_added_date: Time.now,
                transcript_added_by_user_id: episode_added_by_user_id
            )
        end
                
        if episode.save
            {
                episode: episode,
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