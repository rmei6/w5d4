class Visit < ApplicationRecord
  validates :url_id, :visitor_id, presence: true
  
  def self.record_visit!(user, shortened_url)
    create!(visitor_id: user.id, url_id: shortened_url.id)
  end

  

end