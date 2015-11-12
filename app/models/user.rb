# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  validates :email, :uniqueness => true, :presence => true

  has_many :submitted_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "ShortenedUrl"

  has_many :visited_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Visit"

  has_many :visited_long_urls,
    through: :visited_urls
    source: :visited_website

end
