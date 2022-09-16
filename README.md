# README

# テーブル設計

## users テーブル
| Column              | Type        | Option                                                  |
| ------------------- | ----------- | ------------------------------------------------------- |
| nickname            | string      | null:false                                              |
| email               | string      | null:false, UNIQUE                                      |
| encrypted_password  | string      | null:false, min_length: 6, half_width_alphanumeric(mix) |
| family_name         | string      | null:false, full_width                                  |
| last_name           | string      | null:false, full_width                                  |
| family_name_reading | string      | null:false, full_width_katakana                         |
| last_name_reading   | string      | null:false, full_width_katakana                         |
| birth_year          | integer     | null:false, other_than: 0                               |
| birth_month         | integer     | null:false, other_than: 0                               |
| birth_day           | integer     | null:false, other_than: 0                               |

### Association
- has_many :items
- has_many :orders
- has_many :comments

## items テーブル
| Column              | Type        | Option                                                        |
| ------------------- | ----------- | ------------------------------------------------------------- |
| name                | string      | null:false, max_length: 40(full_width)                        |
| description         | text        | null:false, max_length: 1,000(full_width)                     |
| category            | integer     | null:false, other_than: 0                                     |
| condition           | integer     | null:false, other_than: 0                                     |
| delivery_charge     | integer     | null:false, other_than: 0                                     |
| prefecture          | integer     | null:false, other_than: 0                                     |
| delivery_duration   | integer     | null:false, other_than: 0                                     |
| price               | integer     | null:false, min~max_length: 300~9,999,999(half_width_numbers) |
| user                | reference   | null:false, foreign_key: true                                 |

### Association
- belongs_to :user
- has_one :order
- has_many :comments

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
| Column              | Type        | Option                          |
| ------------------- | ----------- | ------------------------------- |
| postal_code         | string      | null:false, /[0-9]{3}-[0-9]{4}/ |
| prefecture          | integer     | null:false, other_than: 0       |
| city                | string      | null:false                      |
| house_number        | string      | null:false                      |
| building_name       | string      |                                 |
| phone_number        | integer     | null:false, /\A\d{11}\z/        |

### Association
- belongs_to :order

## comments テーブル
| Column              | Type        | Option                        |
| ------------------- | ----------- | ----------------------------- |
| content             | text        | null:false                    |
| user                | reference   | null:false, foreign_key: true |
| item                | reference   | null:false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item