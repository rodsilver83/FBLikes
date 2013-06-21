class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :designer_id
      t.string :collection_name
      t.string :collection_slogan
      t.string :description
      t.string :collection_url
      t.string :image
      t.string :thumb
      t.integer :profit_margin_id
      t.date :offer_starts
      t.date :offer_ends
      t.integer :created_by
      t.date :created_at
      t.integer :updated_by
      t.date :updated_at
      t.integer :margin_auth
      t.integer :in_review
      t.integer :published
      t.integer :status

      t.timestamps
    end
  end
end
