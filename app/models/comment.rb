class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable

  validates :body, presence: true
  validates :post_id, presence: true
  validates :user_id, presence: true
end
