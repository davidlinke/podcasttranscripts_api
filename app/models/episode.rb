class Episode < ApplicationRecord
    belongs_to :podcast
    has_one :user
end
