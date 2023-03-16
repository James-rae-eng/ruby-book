class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, 
         :omniauthable, omniauth_providers: %i[facebook]

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

  #def self.from_omniauth(auth)
  #  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #    user.email = auth.info.email || "#{auth.uid}@facebook.com"
  #    user.password = Devise.friendly_token[0, 20]
  #    user.provider = auth.provider
  #    user.uid = auth.uid

  #    user.first_name = auth.info.first_name 
  #    user.last_name = auth.info.last_name
      
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
  #  end
  #end


  def self.from_omniauth(auth)
    oauth_user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name 
      user.last_name = auth.info.last_name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["name"] if user.first_name.blank?
        user.last_name = data["name"] if user.last_name.blank?
      end
    end
  end

end
