class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :fb_id
      t.string :fb_token
      t.string :fb_name
      t.string :fb_gender
      t.string :fb_birthday

      t.timestamps
    end
  end
end
