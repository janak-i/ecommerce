ActiveAdmin.register Product do
  permit_params :name, :description, :price, :image

  # Filterable attributes on the index screen
  filter :name
  filter :description
  filter :price
  filter :image

  # Customize columns displayed on the index screen in the table
  index do
    column :name
    column :description
    column :price
    column :image do |object|
      object.image.present? ? image_tag(object.image, style: 'width: 100px') : nil
    end
    actions
  end
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :image, as: :file
    end
    f.actions
    
  end

end


