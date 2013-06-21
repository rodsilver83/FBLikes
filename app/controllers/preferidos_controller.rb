class PreferidosController < ApplicationController
  def index
    collections = Collection.where(" status > 0 AND offer_starts <= NOW() AND offer_ends >= NOW() AND published = 1");
    index = 0
    @colums = []
    @colums[0] = []
    @colums[1] = []
    @colums[2] = []
    @colums[3] = []
    collections.each do |c|
            
      col = index % 4
      case col
      when 0
        @colums[0].push(c)
      when 1
        @colums[1].push(c)
      when 2
        @colums[2].push(c)
      when 3
        @colums[3].push(c)
      end
      index+=1
    end
  end
  def like
    puts "Preferidos - LIKE"
    collection_id = params["collection_id"]
    user = session[:userDB]
    puts "id_user = #{user.id} AND id_collection = #{collection_id}"
    cldb = CollectionLike.where("id_user = #{user.id} AND id_collection = #{collection_id}")
    puts cldb
    if cldb.empty?
      c = Collection.find(collection_id)
      cl = CollectionLike.new
      cl.id_user = user.id
      cl.id_collection = collection_id
      cl.collection_name = c.collection_name
      cl.collection_slogan = c.collection_slogan
      cl.collection_description = c.description
      cl.collection_image = c.image
      cl.like = 1
      cl.status = 1
      puts cl.inspect
      #cl.save
    else
      puts "LIKE"
    end
    render :layout => 'response'
  end
  def dislike
    #puts "Preferidos - DISLIKE"
    #puts params
    user = session[:userDB]
    render :layout => 'response'
  end
end
