class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :icon_id
      t.string :back_image_id
      t.string :password

      t.timestamps
    end
  end
end
