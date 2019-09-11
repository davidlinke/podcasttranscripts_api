module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :add_podcast, mutation: Mutations::AddPodcast
    field :update_podcast_episodes, mutation: Mutations::UpdatePodcastEpisodes
    field :add_episode_transcript, mutation: Mutations::AddEpisodeTranscript
  end
end
