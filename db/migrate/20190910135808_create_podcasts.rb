class CreatePodcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :rss_url
      t.string :web_url
      t.string :description
      t.string :image_url
      t.timestamp :last_updated
      t.integer :added_by_user
      t.boolean :premium_podcast
      t.string :ignore_keywords

      t.timestamps
    end
  end
end
