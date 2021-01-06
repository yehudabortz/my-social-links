class CreateUsersUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users_users do |t|
      t.string :relationship_type
      t.integer :user_id
    end
  end
end
