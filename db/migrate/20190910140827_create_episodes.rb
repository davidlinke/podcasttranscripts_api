class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.integer :podcast_id
      t.string :title
      t.datetime :published_date
      t.string :description
      t.string :audio_url
      t.integer :duration
      t.string :transcript
      t.timestamp :transcript_added_date
      t.integer :transcript_added_by_user_id

      t.timestamps
    end
  end
end
