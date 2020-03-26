class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments
  belongs_to :user, optional: true
  belongs_to :category, optional: true

  belongs_to_active_hash :prefecture, foreign_key: true
  belongs_to_active_hash :condition, foreign_key: true
  belongs_to_active_hash :deliverypays, foreign_key: true
  belongs_to_active_hash :deliverydate, foreign_key: true
  has_many :images, dependent: :destroy
  has_many :favorites
  has_many :users, through: :favorites
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name,    length: { in: 1..40 }
  validates :info,    length: { in: 1..1000 }
  validates :prefecture_id, numericality: { only_integer: true, greater_than: 0, less_than: 48 }
  validates :condition_id, numericality: { only_integer: true, greater_than: 0, less_than: 7 }
  validates :deliverypays_id, numericality: { only_integer: true, greater_than: 0, less_than: 3 }
  validates :deliverydate_id, numericality: { only_integer: true, greater_than: 0, less_than: 4 }
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000 }

  validates_associated :images
  validates :images, presence: true

  validates_associated :category
  validates :category_id, presence: true
  def self.search(search)
    return Item.all unless search
    Item.where('name LIKE(?)', "%#{search}%")
  end
end
