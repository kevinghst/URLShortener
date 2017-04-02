class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  after_initialize :init

  has_many :urls

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :visited_urls,
    Proc.new { distinct },
    :through => :visits,
    :source => :url
  )

  def init
    self.premium ||= false
  end

end
