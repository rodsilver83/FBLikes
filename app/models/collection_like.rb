class CollectionLike < ActiveRecord::Base
  attr_accessible :collection_description, :collection_image, :collection_name, :collection_slogan, :id_collection, :id_user, :like, :status
end
