class Product < ApplicationRecord
    validates :title, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :inventory, numericality: { greater_than_or_equal_to: 0 }

    scope :available, -> { where(for_sale: true)}
end
