class Post < ApplicationRecord
  
  # userモデルとN:1の関係
  belongs_to :user
  
  #バリデーション
  
  # 値の入力は必須であり、数値かつ０以上の正の整数でなければならない
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  # カテゴリーの選択は必須
  validates :category, presence: true
  
  # 商品名の入力は必須であり、最大５０文字
  validates :product, presence: true, length: { maximum: 50 }
  
end