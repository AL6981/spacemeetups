class User < ActiveRecord::Base
  has_many :meetups_and_users
  has_many :meetups, through: :meetups_and_users
  validates :provider, presence: true
  validates :uid, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true
  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.provider = provider
      user.uid = uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.avatar_url = auth.info.image
    end
  end
end
