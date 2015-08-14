class AddDeletedAtToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :deleted_at, :datetime
    add_index :channels, :deleted_at
  end
end
