class AddViewCountToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :view_count, :integer, default: 0
  end
end
