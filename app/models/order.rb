class Order < ApplicationRecord
	belongs_to :user
	belongs_to :product
	validates :cart_id, presence: true
end
