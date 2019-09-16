module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :add_podcast, mutation: Mutations::AddPodcast
    field :update_podcast_episodes, mutation: Mutations::UpdatePodcastEpisodes
    field :add_episode_transcript, mutation: Mutations::AddEpisodeTranscript
    field :remove_podcast_episode, mutation: Mutations::RemovePodcastEpisode
    field :edit_podcast_episode, mutation: Mutations::EditPodcastEpisode
    field :add_podcast_episode, mutation: Mutations::AddPodcastEpisode
    field :remove_podcast, mutation: Mutations::RemovePodcast
  end
end