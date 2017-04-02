class Tagging < ActiveRecord::Base
  validates :tag_topic_id, presence: true
  validates :url_id, presence: true

  belongs_to :url
  belongs_to :tag_topic


end
