class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :ancestry
      t.string :names_depth_cache

      t.timestamps null: false
    end
  end
end
