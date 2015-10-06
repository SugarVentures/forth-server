class AddCategoryToStreams < ActiveRecord::Migration
  def change
    remove_column :streams, :game
    add_column :streams, :game, :string
    add_column :streams, :category_id, :integer
    add_index :streams, :category_id
  end
end
