class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を含めて入力してください(例 123-4567)' }
    validates :city
    validates :house_number
    validates :phone_number, numericality: { only_integer: true, message: 'は半角数字のみで入力してください(例 08012345678)' },
                             length: { minimum: 10, maximum: 11, message: 'は10桁または11桁で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "を入力してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
