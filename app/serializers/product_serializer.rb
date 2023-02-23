class ProductSerializer < ActiveModel::Serializer
  attributes :id
  attributes :id, :name, :description, :price
end
