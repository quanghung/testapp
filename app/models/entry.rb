class Entry < ActiveRecord::Base
	belongs_to :user,class_name: "User"
	has_many :comments, foreign_key: "entry_id", dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true, length: {maximum: 40}
	validates :body, presence: true, length: {maximum: 200}
	validates :user_id, presence: true

	# Returns entries from the users being followed by the given user.
	  def self.from_users_followed_by(user)
	    followed_user_ids = "SELECT followed_id FROM relationships
	                         WHERE follower_id = :user_id"
	    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
	          user_id: user.id)
	  end
end