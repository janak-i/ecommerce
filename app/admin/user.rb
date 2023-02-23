ActiveAdmin.register User do
  permit_params :email, :password_digest

  # Filterable attributes on the index screen
  filter :email
  filter :password_digest

  # Customize columns displayed on the index screen in the table
  index do
    column :email
    column :password_digest
    actions
  end
end