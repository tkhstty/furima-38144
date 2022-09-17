class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do 
    validates :nickname
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input with full-width characters"}
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input with full-width characters"}
    validates :last_name_reading, format: {with: /\A[ァ-ヶ]+\z/, message: "is invalid. Input with full-width katakana characters"}
    validates :first_name_reading, format: {with: /\A[ァ-ヶ]+\z/, message: "is invalid. Input with full-width katakana characters"}
    validates :birth_date
    validates :encrypted_password, format: {with: /(?=.[a-zA-Z])(?=.\d)[a-zA-Z\d]/, message: "is invalid Input with both half-width digits and alphabets"}
  end
end
