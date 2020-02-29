# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  validates :username, :presence => true
  validates :username, :uniqueness => true

  has_many :own_photos, :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy
  has_many :likes, :foreign_key => "fan_id", :dependent => :destroy
  has_many :comments, :foreign_key => "author_id", :dependent => :destroy
  has_many :follow_requests_sent, :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy
  has_many :follow_requests_received, :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy
  
  has_many :liked_photos, :through => :likes, :source => :photo
  has_many :commented_photos, :through => :comments, :source => :photo
  has_many :leaders, :through => :follow_requests_sent, :source => :recipient
  has_many :followers, :through => :follow_requests_received, :source => :sender
  has_many :feed_photos, :through => :leaders, :source => :own_photos

  has_many :discover, :through => :leaders, :source => :liked_photos

  

end
