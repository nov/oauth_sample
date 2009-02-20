class CreateOauthAccessTokens < ActiveRecord::Migration
  def self.up
    create_table :oauth_access_tokens do |t|
      t.integer :user_id, :oauth_consumer_id
      t.string :token, :limit => 1024, :null => false
      t.string :secret
      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_access_tokens
  end
end
