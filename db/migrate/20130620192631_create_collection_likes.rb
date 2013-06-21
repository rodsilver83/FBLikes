class CreateCollectionLikes < ActiveRecord::Migration
  def change
    create_table :collection_likes do |t|
      t.integer :id_user
      t.integer :id_collection
      t.string :collection_name
      t.string :collection_slogan
      t.string :collection_description
      t.string :collection_image
      t.integer :like
      t.integer :status

      t.timestamps
    end
  end
end
