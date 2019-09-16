require 'rss'
require 'open-uri'
require 'sanitize'

class Mutations::AddPodcast < Mutations::BaseMutation
    argument :rss_url, String, required: true
    argument :premium_podcast, Boolean, required: true
    argument :added_by_user, Integer, required: true
    argument :ignore_keywords, String, required: false
  
    field :podcast, Types::PodcastType, null: false
    field :errors, [String], null: false
  
    def resolve(rss_url:, premium_podcast:, added_by_user:, ignore_keywords:)
        open(rss_url) do |rss|
            begin
                feed = RSS::Parser.parse(rss)
        
                podcast = Podcast.new(
                    title: feed.channel.title,
                    rss_url: rss_url,
                    web_url: feed.channel.link,
                    description: Sanitize.fragment(feed.channel.description).strip.gsub("&nbsp;", " ").gsub("&amp;", "&"),
                    image_url: feed.channel.image.url,
                    added_by_user: added_by_user,
                    premium_podcast: premium_podcast,
                    ignore_keywords: ignore_keywords
                )
                    
                if podcast.save
                    {
                        podcast: podcast,
                        errors: [],
                    }
                else
                    {
                        podcast: nil,
                        errors: podcast.errors.full_messages
                    }
                end

            # rescue RSS::Error
            #     puts 'Bad RSS feed'
            end
        end
    end
end