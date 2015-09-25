class AddImageToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :image, :string
  end
end
