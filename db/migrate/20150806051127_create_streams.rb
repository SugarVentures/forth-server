class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :title,              null: false, default: ""
      t.string :game
      t.datetime :start
      t.datetime :end
      t.string :stream_key,         null: false, default: ""
      t.integer :view_mode
      t.integer :age_restriction,   null: false, default: 0
      t.boolean :group
      t.boolean :discussion
      t.text :description
      t.references :channel
      t.references :user

      t.timestamps null: false
    end
  end
end
