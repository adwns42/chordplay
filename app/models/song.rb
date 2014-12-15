class Song < ActiveRecord::Base
  has_and_belongs_to_many :chords

  validates :source_url, presence: true
  validates :title, presence: true
end
