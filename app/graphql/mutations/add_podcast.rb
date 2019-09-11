require 'rss'
require 'open-uri'

class Mutations::AddPodcast < Mutations::BaseMutation
    argument :rss_url, String, required: true
    argument :premium_podcast, Boolean, required: true
    argument :added_by_user, Integer, required: true
    argument :ignore_keywords, String, required: false
  
    field :podcast, Types::PodcastType, null: false
    field :errors, [String], null: false
  
    def resolve(rss_url:, premium_podcast:, added_by_user:, ignore_keywords:)
        open(rss_url) do |rss|
            feed = RSS::Parser.parse(rss)

            cleaned_description = feed.channel.description.gsub("\n", "").gsub("<p>", "").gsub("</p>", "").strip
    
            podcast = Podcast.new(
                title: feed.channel.title,
                rss_url: rss_url,
                web_url: feed.channel.link,
                description: cleaned_description,
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
        end
    end
end