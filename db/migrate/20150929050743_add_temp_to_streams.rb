class AddTempToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :temp, :boolean
  end
end
