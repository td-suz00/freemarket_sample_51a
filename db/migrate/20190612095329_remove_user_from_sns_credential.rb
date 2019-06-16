class RemoveUserFromSnsCredential < ActiveRecord::Migration[5.2]
  def change
    remove_reference :sns_credentials, :user, foreign_key: true
    add_column :sns_credentials, :email, :string, null: false
  end
end
