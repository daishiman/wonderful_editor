class AddUserIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :user, :foreign_key => true
    change_column_null :comments, :user_id, false
  end
end
