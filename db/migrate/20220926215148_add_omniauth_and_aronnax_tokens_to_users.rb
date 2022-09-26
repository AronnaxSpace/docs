class AddOmniauthAndAronnaxTokensToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :aronnax_access_token, :string
    add_column :users, :aronnax_refresh_token, :string
  end
end
