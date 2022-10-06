require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 0.5
  end

  describe '商品購入機能' do
    context '購入できる時' do
      it '必要な情報が全て入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物名は任意であること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '購入できない時' do
      it '郵便番号が必須であること' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "郵便番号を入力してください"
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと(ハイフンなし)' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include '郵便番号はハイフン(-)を含めて入力してください(例 123-4567)'
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと(全角含む)' do
        @order_address.postal_code = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include '郵便番号はハイフン(-)を含めて入力してください(例 123-4567)'
      end
      it '都道府県が必須であること' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "都道府県を入力してください"
      end
      it '市区町村が必須であること' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "市区町村を入力してください"
      end
      it '番地が必須であること' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "番地を入力してください"
      end
      it '電話番号が必須であること' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "電話番号を入力してください"
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（ハイフン込み）' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include '電話番号は半角数字のみで入力してください(例 08012345678)'
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（全角込み）' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include '電話番号は半角数字のみで入力してください(例 08012345678)'
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（10文字未満）' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include '電話番号は10桁または11桁で入力してください'
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（12文字以上）' do
        @order_address.phone_number = '012345678901'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include '電話番号は10桁または11桁で入力してください'
      end
      it 'user_idが空では購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "ユーザー情報を入力してください"
      end
      it 'item_idが空では購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "商品情報を入力してください"
      end
      it 'tokenが空では購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
    end
  end
end
