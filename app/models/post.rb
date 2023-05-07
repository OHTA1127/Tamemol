class Post < ApplicationRecord
  belongs_to :user
  
  #バリデーション
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :category, presence: true
  validates :product, presence: true, length: { maximum: 50 }
  
end