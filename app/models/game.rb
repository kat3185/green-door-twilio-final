class Game < ActiveRecord::Base
  scope :short_title_like, ->(name) {where "LOWER(short_title) LIKE ?", "%#{name}%"}
  self.per_page = 3
end
