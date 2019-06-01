class AddColumnSellerIdToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :seller_id, :integer, null: false, foreign_key: true
  end
end
