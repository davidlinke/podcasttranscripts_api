class Podcast < ApplicationRecord
    has_many :episodes
    has_one :user
end
