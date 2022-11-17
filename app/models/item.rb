class Item < ApplicationRecord
  with_options presence: true do
    validates :name, length: { maximum: 40, message: 'は40文字以内で入力してください' }
    validates :description, length: { maximum: 1000, message: 'は1000文字以内で入力してください' }
    validates :category_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :condition_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :delivery_charge_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :prefecture_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :delivery_duration_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'は300円から9,999,999円の間で半角数字で入力してください' }
    validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
  end

  belongs_to :user
  has_one :order
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_duration
end
