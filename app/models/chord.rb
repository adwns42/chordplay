class Chord < ActiveRecord::Base
  has_and_belongs_to_many :songs

  validates :name, presence: true
end
