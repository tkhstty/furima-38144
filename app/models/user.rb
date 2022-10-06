class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }
    validates :last_name_reading, format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角カナで入力してください' }
    validates :first_name_reading,
              format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角カナで入力してください' }
    validates :birth_date
  end

  validates :password,
            format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/,
                      message: 'は半角英数字両方を含めてください' }

  has_many :items
  has_many :orders
end
