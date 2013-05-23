# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :userID
  has_secure_password
  
 has_many :microposts, dependent: :destroy
 has_many :relationships, foreign_key: "follower_id", dependent: :destroy
 has_many :followed_users, through: :relationships, source: :followed
 
  has_many :reverse_relationships, foreign_key: "followed_id",
    class_name: "Relationship",
    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50}
  validates :userID, presence: true, format: { with: /[a-zA-Z0-9\-_]/}, length: { minimum: 4,maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }

  validates :password, presence: true, format: { with: /[a-zA-Z0-9]/},length: { minimum: 4,maximum: 8 }
  validates :password_confirmation, presence: true

 def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end


  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
 
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

  class << self
   def search(nameid)
    rel = order("created_at")
   if nameid.present?
     rel = rel.where("userID LIKE ?","%#{nameid}%")
   end 
     rel
    end
  end



end
