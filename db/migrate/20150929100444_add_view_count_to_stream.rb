class AddViewCountToStream < ActiveRecord::Migration
  def change
    add_column :streams, :view_count, :integer, default: 0
  end
end
