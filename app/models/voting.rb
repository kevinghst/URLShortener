class Voting < ActiveRecord::Base
  validates :user_id, presence: true
  validates :url_id, presence: true

  belongs_to :url

  def self.create_vote(user_id, url_id, score)
    self.prevent_self_vote(user_id, url_id)
    self.prevent_repeat_vote(user_id, url_id)
    Voting.create!({ user_id: user_id, url_id: url_id, score: score })
  end

  def self.prevent_self_vote(user_id, url_id)
    user = User.find(user_id)
    if user.visited_urls.any? { |u| u.id == url_id }
      raise "can't vote for your own URL dummy!"
    end
  end

  def self.prevent_repeat_vote(user_id, url_id)
    if Voting.all.any? { |v| v.user_id == user_id && v.url_id == url_id }
      raise "can't vote for the same shit twice!"
    end
  end

end
