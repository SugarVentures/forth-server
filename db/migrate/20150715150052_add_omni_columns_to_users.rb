class AddOmniColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_id, :string
    add_column :users, :fabric_id, :string
    add_column :users, :fabric_auth_token, :string
    add_column :users, :fabric_auth_token_secret, :string
  end
end
