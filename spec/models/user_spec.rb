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
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'メールアドレスが必須である' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'メールアドレスが一意性である' do
        @user.save
        @email_test_user = FactoryBot.build(:user, email: @user.email)
        @email_test_user.valid?
        expect(@email_test_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
      it 'メールアドレスは、@を含む必要がある' do
        @user.email = 'testemail'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it 'パスワードが必須である' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'パスワードは、6文字以上での入力が必須である' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'パスワードは、英字のみでは登録できない' do
        @user.password = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英数字両方を含めてください'
      end
      it 'パスワードは、数字のみでは登録できない' do
        @user.password = '12341234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英数字両方を含めてください'
      end
      it 'パスワードは、全角文字を含むと登録できない' do
        @user.password = 'ＴＥＳＴ1234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英数字両方を含めてください'
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須である' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
    end
  end

  describe '新規登録/本人情報確認' do
    context '新規登録が出来ない時' do
      it 'お名前(全角)は、名字が必須である' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "姓を入力してください"
      end
      it 'お名前(全角)は、名前が必須である' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名を入力してください"
      end
      it 'お名前(全角)の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
        @user.last_name = 'sato'
        @user.valid?
        expect(@user.errors.full_messages).to include '姓は全角で入力してください'
      end
      it 'お名前(全角)の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須である' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include '名は全角で入力してください'
      end
      it 'お名前カナ(全角)は、名字が必須である' do
        @user.last_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "姓カナを入力してください"
      end
      it 'お名前カナ(全角)は、名前が必須である' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名カナを入力してください"
      end
      it 'お名前(全角)の名字は、全角（カタカナ）での入力が必須である' do
        @user.last_name_reading = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include '姓カナは全角カナで入力してください'
      end
      it 'お名前(全角)の名前は、全角（カタカナ）での入力が必須である' do
        @user.first_name_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include '名カナは全角カナで入力してください'
      end
      it '生年月日が必須である' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "生年月日を入力してください"
      end
    end
  end
end
