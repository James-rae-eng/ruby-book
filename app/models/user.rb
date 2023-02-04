class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes
  has_one :profile
  has_one_attached :avatar

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :received_friend_requests, foreign_key: :receiver_id, class_name: "FriendRequest", dependent: :destroy
  has_many :sent_friend_requests, foreign_key: :sender_id, class_name: "FriendRequest", dependent: :destroy
  has_many :initiated_friendships, foreign_key: :user_id, class_name: "Friendship", dependent: :destroy
  has_many :accepted_friendships, foreign_key: :friend_id, class_name: "Friendship", dependent: :destroy
  has_many :initiated_friends, through: :initiated_friendships, source: :friend, dependent: :destroy
  has_many :accepted_friends, through: :accepted_friendships, source: :user, dependent: :destroy

  def friends
    initiated_friends + accepted_friends
  end

  def friend?(other_user)
    friends.include?(other_user)
  end

  def can_send_request_to?(other_user)
    !friend?(other_user) && self != other_user &&
    !sent_request_to?(other_user) && !received_request_from?(other_user)
  end

  def sent_request_to?(other_user)
    sent_friend_requests.any? { |request| request.receiver == other_user }
  end

  def received_request_from?(other_user)
    received_friend_requests.any? { |request| request.sender == other_user }
  end


end
