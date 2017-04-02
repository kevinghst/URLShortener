class Url < ActiveRecord::Base
  validates :long_url, presence: true, uniqueness: true

  belongs_to :user

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :user
  )

  has_many :taggings

  has_many(
    :tag_topics,
    :through => :taggings,
    :source => :tag_topic
  )

  def self.random_code
    code = SecureRandom::urlsafe_base64
    unless Url.exists?(:short_url => code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_new_url(user_id, long_url)
    user = User.find(user_id)

    self.no_spamming(user)
    self.nonpremium_max(user)

    new_url = Url.create!({
      long_url: long_url,
      short_url: self.random_code,
      clicks: 0,
      user_id: user_id
    })
    new_url
  end

  def num_clicks
    self.visits.select(:user_id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_uniques_recent
    self.visits
      .where("created_at > ?", 10.minutes.ago)
      .select(:user_id)
      .distinct
      .count
  end

  # Prevent users from submitting more than 5 URLs in a single minute
  def self.no_spamming(user)
    numbers = user.urls
      .where("created_at > ?", 1.minute.ago)
      .count

    if numbers >= 5
      raise "no spamming!"
    end
  end

  def self.nonpremium_max(user)
    if user.premium == false
      numbers = user.urls.count
      if numbers >= 5
        raise "above premium allowance!"
      end
    end
  end


end
