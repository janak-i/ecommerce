class DropLineItems < ActiveRecord::Migration[7.0]
  def change
    drop_table :line_items

  end
end
