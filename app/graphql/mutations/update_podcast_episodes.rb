require 'rss'
require 'open-uri'
require 'date'
require 'sanitize'

class Mutations::UpdatePodcastEpisodes < Mutations::BaseMutation
    argument :podcast_id, ID, required: true
     
    field :podcast, Types::PodcastType, null: false
    field :errors, [String], null: false
  
    def resolve(podcast_id:)
        foundPodcast = Podcast.find(podcast_id)

        open(foundPodcast.rss_url) do |rss|
            feed = RSS::Parser.parse(rss)

            feed.items.each do |ep|
                if foundPodcast.last_updated.nil? || foundPodcast.last_updated.to_i < ep.pubDate.to_i
                    episode = Episode.new(
                        podcast_id: foundPodcast.id,
                        title: ep.title,
                        published_date: ep.pubDate,
                        description: Sanitize.fragment(ep.description).strip.gsub("&nbsp;", " ").gsub("&amp;", "&"),
                        audio_url: ep.enclosure.url,
                        duration: ep.enclosure.length
                        )
                        puts episode
                        episode.save
                end
            end
        end

        foundPodcast.update(last_updated: Time.now)

        if foundPodcast.save
            {
                podcast: foundPodcast,
                errors: []
            }
        else
            {
                podcast: nil,
                errors: podcast.errors.full_messages
            }
        end
    end
end