class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name,               null: false, index: true
      t.text       :text,               null: false
      t.references :category,           null: false, foreign_key: true
      t.references :size,               null: false, foreign_key: true
      t.references :brand,              optional: true, foreign_key: true
      t.string     :condition,          null: false
      t.string     :delivery_fee_payer, null: false
      t.string     :delivery_type,      null: false
      t.string     :delibery_from_area, null: false
      t.string     :delivery_days,      null: false
      t.integer    :price,              null: false
      
      t.timestamps
    end
  end
end
