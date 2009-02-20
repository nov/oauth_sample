class User < ActiveRecord::Base
  has_many :oauth_access_tokens
  validates_presence_of :identifier
  validates_uniqueness_of :identifier
end
