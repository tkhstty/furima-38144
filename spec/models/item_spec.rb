require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる時' do
      it '必要な情報が入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない時' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "商品画像を入力してください"
      end
      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it '商品名が40文字以下であること' do
        @item.name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include '商品名は40文字以内で入力してください'
      end
      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end
      it '商品の説明が1000文字以下であること' do
        @item.description = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の説明は1000文字以内で入力してください'
      end
      it 'カテゴリーの情報が必須であること' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを入力してください"
      end
      it '商品の状態の情報が必須であること' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を入力してください"
      end
      it '配送料の負担の情報が必須であること' do
        @item.delivery_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を入力してください"
      end
      it '発送元の地域の情報が必須であること' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を入力してください"
      end
      it '発送までの日数の情報が必須であること' do
        @item.delivery_duration_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を入力してください"
      end
      it '価格の情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "価格を入力してください"
      end
      it '価格は、¥300以下では保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円から9,999,999円の間で半角数字で入力してください'
      end
      it '価格は、¥9,999,999以上では保存できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円から9,999,999円の間で半角数字で入力してください'
      end
      it '価格は半角数値のみ保存可能であること' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円から9,999,999円の間で半角数字で入力してください'
      end
      it 'userが存在しなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'ユーザー情報を入力してください'
      end
    end
  end
end
