class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :status
      t.text :image

      t.timestamps
    end
  end
end
