class Micropost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'like_id'
  
  
  def like(micropost)
   self.favorites.find_or_create_by(like_id: micropost.id)
  end  
  
  def unlike(micropost)
    favorite = self.favorites.find_by(like_id: micropost.id)
    favorite.destroy if favorite
  end

  def likes?(micropost)
    self.likes.include?(micropost)
  end

end