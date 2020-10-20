# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nick_name|string|null: false|
|email|string|null: false, index: true, unique: true|
|password|string|null: false|

### Association
- has_one :profile
- has_one :comment
- has_one :credit_card
- has_many :destinations
- has_many :purchase_histories
- has_many :items
- has_many :comments
- has_many :favorite_items


## profilesテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|user_id|reference|null: false, foreign_key: true|


### Association
- belongs_to :user


## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|customer_token|string|null: false|

### Association
- belongs_to :user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|string|
|user_id|reference|null: false|

### Association
- belongs_to :user


## destinationsテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|postal_code|string|null: false, limit: 8|
|prefecture|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string|
|telephone|string|
|user_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :user

## purchase_historiesテーブル
|Column|Type|Options|
|------|----|-------|
|trading_day|datetime|
|user_id|reference|foreign_key: true|
|item_id|reference|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|introduction|text|null: false|
|trading_status_id|reference|null: false|
|category_id|reference|null: false, foreign_key: true|
|brand_id|reference|foreign_key: true|
|condition_id|reference|null: false, foreign_key: true|
|shipping_cost_id|reference|null: false, foreign_key: true|
|preparation_day_id|reference|null: false, foreign_key: true|
|prefecture_id|reference|null: false, foreign_key: true|
|user_id|reference|null: false, foreign_key: true|

### Association
- has_many :item_images
- has_many :purchase_histories
- has_many :comments
- has_many :favorite_items
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping_cost
- belongs_to_active_hash :preparation_day
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :trading_status


## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|src|string|null: false|
|item_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :item

## conditionテーブル

|Column|Type|Options|
|------|----|-------|
|content|string|null: false|

### Association
- has_many :items


## shipping_costsテーブル

|Column|Type|Options|
|------|----|-------|
|content|string|null: false|

### Association
- has_many :items


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

### Association
- has_many :items

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items


## preparation_daysテーブル

|Column|Type|Options|
|------|----|-------|
|period|string|null: false|

### Association
- has_many :items


## prefecturesテーブル

|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false|

### Association
- has_many :items

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## favorite_itemsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
