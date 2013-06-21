class Collection < ActiveRecord::Base
  establish_connection "live_trendyta"
  set_table_name "collection"
  
  attr_accessible :collection_name, :collection_slogan, :collection_url, :created_at, :created_by, :description, :designer_id, :image, :in_review, :margin_auth, :offer_ends, :offer_starts, :profit_margin_id, :published, :status, :thumb, :updated_at, :updated_by
  def readonly?
    return true
  end
  def readonly!
  end
end
