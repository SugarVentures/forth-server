class AddIndexStreamStreamKey < ActiveRecord::Migration
  def change
    add_index :streams, :stream_key
  end
end
