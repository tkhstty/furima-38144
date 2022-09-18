require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録が出来る時' do
      it 'ユーザー情報と本人情報が全て存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録が出来ない時' do
      it 'ニックネームが必須である' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが必須である' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性である' do
        @user.save
        @email_test_user = FactoryBot.build(:user, email: @user.email)
        @email_test_user.valid?
        expect(@email_test_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'メールアドレスは、@を含む必要がある' do
        @user.email = 'testemail'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'パスワードが必須である' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以上での入力が必須である' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードは、英字のみでは登録できない' do
        @user.password = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Input with both half-width digits and alphabets'
      end
      it 'パスワードは、数字のみでは登録できない' do
        @user.password = '12341234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Input with both half-width digits and alphabets'
      end
      it 'パスワードは、全角文字を含むと登録できない' do
        @user.password = 'ＴＥＳＴ1234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Input with both half-width digits and alphabets'
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須である' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
    end
  end

  describe '新規登録/本人情報確認' do
    context '新規登録が出来ない時' do
      it 'お名前(全角)は、名字が必須である' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'お名前(全角)は、名前が必須である' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'お名前(全角)の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
        @user.last_name = 'sato'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid. Input with full-width characters'
      end
      it 'お名前(全角)の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid. Input with full-width characters'
      end
      it 'お名前カナ(全角)は、名字が必須である' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name reading can't be blank"
      end
      it 'お名前カナ(全角)は、名前が必須である' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name reading can't be blank"
      end
      it 'お名前(全角)の名字は、全角（カタカナ）での入力が必須である' do
        @user.last_name_reading = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name reading is invalid. Input with full-width katakana characters'
      end
      it 'お名前(全角)の名前は、全角（カタカナ）での入力が必須である' do
        @user.first_name_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name reading is invalid. Input with full-width katakana characters'
      end
      it '生年月日が必須である' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
    end
  end
end
