require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe "商品購入機能" do
    context "購入できる時" do
      it "必要な情報が全て入力されていれば購入できる" do
        expect(@order_address).to be_valid
      end
      it "建物名は任意であること" do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context "購入できない時" do
      it "郵便番号が必須であること" do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Postal code can't be blank"
      end
      it "郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと(ハイフンなし)" do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Postal code is invalid. Enter it as follows (e.g. 123-4567)'
      end
      it "郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと(全角含む)" do
        @order_address.postal_code = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Postal code is invalid. Enter it as follows (e.g. 123-4567)'
      end
      it "都道府県が必須であること" do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it "市区町村が必須であること" do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "City can't be blank"
      end
      it "番地が必須であること" do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "House number can't be blank"
      end
      it "電話番号が必須であること" do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Phone number can't be blank"
      end
      it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（ハイフン込み）" do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（全角込み）" do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（10文字未満）" do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input 10 or 11 character'
      end
      it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（12文字以上）" do
        @order_address.phone_number = '012345678901'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone number is invalid. Input 10 or 11 character'
      end
      it "user_idが空では購入できない" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "User can't be blank"
      end
      it "item_idが空では購入できない" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Item can't be blank"
      end
      it "tokenが空では購入できない" do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Token can't be blank"
      end
    end
  end
end
