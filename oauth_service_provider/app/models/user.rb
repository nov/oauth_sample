class User < ActiveRecord::Base
  has_many :activities, :source => :actor, :dependent => :destroy
  has_many :access_tokens
  has_many :client_applications
  has_many :tokens, :class_name => 'OauthToken'

  validates_presence_of   :identifier
  validates_uniqueness_of :identifier
end
