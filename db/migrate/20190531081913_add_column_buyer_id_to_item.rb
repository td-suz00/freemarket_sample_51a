class AddColumnBuyerIdToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :buyer_id, :integer, optional: true, foreign_key: true
  end
end
