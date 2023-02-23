class User < ApplicationRecord
	has_many :orders
	has_many :products, through: :orders
	enum :user_role, {admin: 0,user:1 }
end
