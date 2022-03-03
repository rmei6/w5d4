class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, :user_id, presence: true

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while self.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end
    code    
  end

  def self.new_url(user, long_url)
    self.create!(short_url: self.random_code, long_url: long_url, user_id: user.id)
  end

  has_one :submitter,
    primary_key: :user_id,
    foreign_key: :id,
    class_name: :User

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitors,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

end