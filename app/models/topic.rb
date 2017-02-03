class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :sponsoredPosts, dependent: :destroy
end
