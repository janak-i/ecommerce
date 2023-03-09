class Product < ApplicationRecord
	has_many :orders
	has_many :users, through: :orders
	has_one_attached :image
	belongs_to :cart
	validates :name, presence: true
	# default_scope { where(published: "true") }
	# scope :find_name, ->{where("name =?",'Bat')}
	# scope :find_description, ->{where("description =?", "The virat kohli bat mrf")}

end


