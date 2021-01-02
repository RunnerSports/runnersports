class Product < ApplicationRecord
    validates :title, :price, presence: true
end
