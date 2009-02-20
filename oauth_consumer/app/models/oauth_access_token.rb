class OauthAccessToken < ActiveRecord::Base
  belongs_to :user
  belongs_to :oauth_consumer

  # NOTE:
  # Service providers using only RSA-SHA1 may not generate access_token_secret ??
  # ref.) http://devlog.agektmr.com/ja/archives/174
  validates_presence_of :token, :secret, :user_id, :oauth_consumer_id
  validates_uniqueness_of :token
end
