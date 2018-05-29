class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.json :images
      t.integer :created_by
      t.string :from
      t.string :to
      t.integer :provider_id
      t.integer :provider_order_id
      t.timestamps
    end
  end
end
