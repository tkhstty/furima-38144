class Item < ApplicationRecord
  with_options presence: true do
    validates :name, length: { maximum: 40, message: 'is too long (maximum is 40 characters)' }
    validates :description, length: { maximum: 1000, message: 'is too long (maximum is 1000 characters)' }
    validates :category_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :condition_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :delivery_charge_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :delivery_duration_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is invalid' }
    validates :image
  end

  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_duration
end
