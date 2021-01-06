class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.integer :user_id
    end
  end
end
