require 'rss'
require 'open-uri'
require 'date'

class Mutations::UpdatePodcastEpisodes < Mutations::BaseMutation
    argument :podcast_id, ID, required: true
     
    field :podcast, Types::PodcastType, null: false
    field :errors, [String], null: false
  
    def resolve(podcast_id:)

        foundPodcast = Podcast.find(podcast_id)
        # if (!foundPodcast || !foundPodcast.rss_url)
        #    throw new Error("Couldn't find podcast");
        # end

        open(foundPodcast.rss_url) do |rss|
            feed = RSS::Parser.parse(rss)

            feed.items.each do |ep|
                if foundPodcast.last_updated.nil? || foundPodcast.last_updated.to_i < ep.pubDate.to_i
                    episode = Episode.new(
                        podcast_id: foundPodcast.id,
                        title: ep.title,
                        published_date: ep.pubDate,
                        description: ep.description.gsub("\n", "").strip,
                        audio_url: ep.enclosure.url,
                        duration: ep.enclosure.length
                        )
                        puts episode
                        episode.save
                end
            end
                # if !foundPodcast.last_updated.nil?
                #     updated = foundPodcast.last_updated
                # else
                #     updated = 0
                # end
                # puts updated.to_i
                # puts foundPodcast.last_updated.nil?
                # puts Time.now.to_time
                # PODCAST DATE FORMAT: Thu, 21 May 2015 02:43:11 -0000
                # ITEM.PUBDATE IS IN THE RUBY TIME FORMAT
                # puts item.pubDate
                # puts item.pubDate.instance_of? String
                # puts item.pubDate.class
                # d = DateTime.strptime(item.pubDate, '     %d %m %Y %H:%M:%S')
                # puts d
                # d = item.pubDate
                # puts d.to_i

                # SET LAST UPDATED DATE FIELD
                # CURRENT TIMESTAMP IS Time.now.to_i
        end

        foundPodcast.update(last_updated: Time.now)


        if foundPodcast.save
            {
                podcast: foundPodcast,
                errors: [],
            }
        else
            {
                podcast: nil,
                errors: podcast.errors.full_messages
            }
        end





   


    end
end