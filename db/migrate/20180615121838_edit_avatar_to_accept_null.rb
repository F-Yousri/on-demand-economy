class EditAvatarToAcceptNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users ,:avatar ,true
  end
end
