class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title,            default: "",    null: false  
      t.text :description
      t.string :icon
      t.string :banner
      t.integer :components
      t.references :user

      t.timestamps null: false
    end
  end
end
