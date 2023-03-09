ActiveAdmin.register Order do
  permit_params :user_id, :product_id

  # Filterable attributes on the index screen
  filter :user_id
  filter :product_id


  # Customize columns displayed on the index screen in the table
  index do
    column :user_id
    column :product_id
    column :price
    actions
  end
  form do |f|
    f.inputs do
      f.input :user_id
      f.input :product_id
    end
    f.actions
    
  end
end


