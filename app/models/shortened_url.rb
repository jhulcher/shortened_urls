# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :text             not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Visit"

  has_many :site_visitors,
    through: :visitors,
    source: :visitor

  def num_clicks

  end

  def self.random_code
    begin
      generated_url = SecureRandom.urlsafe_base64(12)
      raise "url exists" if ShortenedUrl.exists? generated_url
    rescue
      retry
    end
    generated_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    user_id = user.id
    short_url = ShortenedUrl.random_code
    ShortenedUrl.new(long_url: long_url, short_url: short_url, user_id: user_id).save!
  end

end
