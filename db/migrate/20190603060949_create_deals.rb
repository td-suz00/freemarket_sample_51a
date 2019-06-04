class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.string :charge_id, unique: true
      t.datetime :deal_at
      t.integer :buyer_id, foreign_key: true, optional: true
      t.integer :seller_id, foreign_key: true, null: false
      t.references :status, foreign_key: true, default: 1
      t.references :item, foreign_key: true, null: false
      t.timestamps
    end
  end
end
