class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :user, uniqueness: { scope: :song }
end
