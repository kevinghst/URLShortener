class Visit < ActiveRecord::Base
  validates :user_id, :url_id, presence: true

  belongs_to :user
  belongs_to :url

  def self.record_visit!(user_id, url_id)
    Visit.create!({
      user_id: user_id,
      url_id: url_id
    })
  end




end
