# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  message    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  attr_accessible :message, :user_id
  belongs_to :user
  validates :message, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'posts.created_at DESC'
end
