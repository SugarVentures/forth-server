class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: "", null: false, uniq: true
    add_column :users, :birthday, :datetime
    add_column :users, :min_age, :integer
  end
end
