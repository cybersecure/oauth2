class CreateOauth2Users < ActiveRecord::Migration
  def change
    create_table :oauth2_users do |t|
      t.string :username
      t.string :login_token
      t.string :auth_token
      t.string :access_token
      t.integer :expires_in
      t.string :refresh_token

      t.timestamps
    end
  end
end
