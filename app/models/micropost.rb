class Micropost < ActiveRecord::Base
  attr_accessible :content
  validates :user_id, presence: true
  validates :content, presence: true, allow_blank: false, length: {maximum: 140}
  belongs_to :user

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)

    #followed_users_id = user.followed_user_ids
    #microposts = where("user_id IN(?) OR user_id = ?", followed_users_id, user.id)

    followed_users_id = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN(#{followed_users_id}) OR user_id = :user_id", user_id: user.id)

  end
end
