class User < ApplicationRecord
  #microposts関連付け
  has_many :microposts, dependent: :destroy
  #1対多の関連付け
  has_many :active_relationships, class_name:   "Relationship",
                                  foreign_key:  "follower_id",
                                  dependent:    :destroy
  has_many :passive_relationships,  class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  #多対多の関連付け
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #validates_presence_of :username
  #validates_uniqueness_of :username, case_sensitive: false
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable
  #自己紹介分のバリデーション
  validates :introduction, presence: false, length: { maximum: 50 }

        def self.from_omniauth(auth)
          find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
            user.provider = auth["provider"]
            user.uid = auth["uid"]
            user.username = auth["info"]["nickname"]
          end
        end
      
        def self.new_with_session(params, session)
          if session["devise.user_attributes"]
            new(session["devise.user_attributes"]) do |user|
              user.attributes = params
            end
          else
            super
          end
        end

        def feed
          following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
          Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
        end

        #ユーザーをフォローする
        def follow(other_user)
          following << other_user
        end

        #ユーザーをフォロー解除する
        def unfollow(other_user)
          active_relationships.find_by(followed_id: other_user.id).destroy
        end

        #現在のユーザーがフォローしていたらtrueを返す
        def following?(other_user)
          following.include?(other_user)
        end

        #image関連付け
        mount_uploader :image, ImageUploader

        #def to_param
        #  username
        #end
end
