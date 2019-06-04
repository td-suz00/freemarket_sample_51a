class RemoveUserIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :seller_id, :integer
    remove_column :items, :buyer_id, :integer
  end
end
