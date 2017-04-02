class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many :taggings
  has_many(
    :urls,
    :through => :taggings,
    :source => :url
  )

  def popular_links
    self.urls
      .joins(:visits)
      .group(:long_url)
      .order('COUNT(*) DESC')
      .limit(5)
      .select('long_url, COUNT(*) as number_of_visits')
  end




end
