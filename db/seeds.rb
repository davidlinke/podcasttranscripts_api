# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create([
  { email: 'admin@podcasts.com', password: 'mysecret', admin: true },
  { email: 'david@david.com', password: 'no', admin: false },
  { email: 'friend@gmail.com', password: 'something', admin: false },
  { email: 'help@podcasts.com', password: 'unique', admin: false },
])

puts "Seeded Users"

# 5.times do
#     Podcast.create(
#         title: Faker::Book.title,
#         rss_url: Faker::Internet.url,
#         web_url: Faker::Internet.url,
#         description: Faker::Lorem.sentence(word_count: 50),
#         image_url: Faker::Internet.url,
#         last_updated: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now),
#         added_by_user: Faker::Number.within(range: 1..4),
#         premium_podcast: Faker::Boolean.boolean,
#         ignore_keywords: "Premium Feed"
#     )
# end
    
# puts "Seeded Podcasts"

# 100.times do
#     Episode.create(
#         podcast_id: Faker::Number.within(range: 1..5),
#         title: Faker::Book.title,
#         published_date: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now),
#         image_url: Faker::Internet.url,
#         description: Faker::Lorem.sentence(word_count: 50),
#         audio_url: Faker::Internet.url,
#         duration: Faker::Number.within(range: 1000..10000),
#         transcript: Faker::Lorem.sentence(word_count: 1000),
#         transcript_added_date: Faker::Time.between(from: DateTime.now - 10, to: DateTime.now),
#         transcript_added_by_user_id: Faker::Number.within(range: 1..4)
#     )
# end

# puts "Seeded Episodes"