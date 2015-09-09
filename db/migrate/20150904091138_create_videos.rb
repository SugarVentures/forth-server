class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :file
      t.integer :stream_id

      t.timestamps null: false
    end
  end
end
