class CreateOauthConsumers < ActiveRecord::Migration
  def self.up
    create_table :oauth_consumers do |t|
      t.string :service_provider, :consumer_key, :consumer_secret, :scope
      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_consumers
  end
end
