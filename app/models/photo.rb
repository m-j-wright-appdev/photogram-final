# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord

  validates :image, :presence => true

  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :owner, :class_name => "User" 

  has_many :fans, :through => :likes, :source => :fan
  has_many :authors, :through => :comments, :source => :author
  has_many :followers, :through => :owner, :source => :leaders

end
