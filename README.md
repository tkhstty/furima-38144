# README

# テーブル設計

## users テーブル
| Column              | Type        | Option                   |
| ------------------- | ----------- | ------------------------ |
| nickname            | string      | null:false               |
| email               | string      | null:false, unique: true |
| encrypted_password  | string      | null:false               |
| last_name           | string      | null:false               |
| first_name          | string      | null:false               |
| last_name_reading   | string      | null:false               |
| first_name_reading  | string      | null:false               |
| birth_date          | date        | null:false               |

### Association
- has_many :items
- has_many :orders
- has_many :comments

## items テーブル
| Column               | Type        | Option                        |
| -------------------- | ----------- | ----------------------------- |
| name                 | string      | null:false                    |
| description          | text        | null:false                    |
| category_id          | integer     | null:false                    |
| condition_id         | integer     | null:false                    |
| delivery_charge_id   | integer     | null:false                    |
| prefecture_id        | integer     | null:false                    |
| delivery_duration_id | integer     | null:false                    |
| price                | integer     | null:false                    |
| user                 | reference   | null:false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order
- has_many :comments
- belongs_to : category
- belongs_to : condition
- belongs_to : delivery_charge
- belongs_to : prefecture
- belongs_to : delivery_duration

## orders テーブル
| Column              | Type        | Option                        |
| ------------------- | ----------- | ----------------------------- |
| user                | reference   | null:false, foreign_key: true |
| item                | reference   | null:false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル
| Column              | Type        | Option                        |
| ------------------- | ----------- | ----------------------------- |
| postal_code         | string      | null:false                    |
| prefecture_id       | integer     | null:false                    |
| city                | string      | null:false                    |
| house_number        | string      | null:false                    |
| building_name       | string      |                               |
| phone_number        | string      | null:false                    |
| order               | reference   | null:false, foreign_key: true |

### Association
- belongs_to :order
- belongs_to :prefecture

## comments テーブル
| Column              | Type        | Option                        |
| ------------------- | ----------- | ----------------------------- |
| content             | text        | null:false                    |
| user                | reference   | null:false, foreign_key: true |
| item                | reference   | null:false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item