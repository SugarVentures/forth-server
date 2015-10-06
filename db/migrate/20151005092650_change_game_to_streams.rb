class ChangeGameToStreams < ActiveRecord::Migration
  def change
    remove_column :streams, :game
    add_column :streams, :game, :integer
  end
end
