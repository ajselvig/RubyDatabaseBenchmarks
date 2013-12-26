require './runner'
require 'nobrainer'

class NoBrainerPost
  include NoBrainer::Document

  field :title#, type: String
  field :body#, type: String
  field :posted_at#, type: Date
end


class NoBrainerRunner < Runner

  def initialize
    super
    NoBrainer.configure do |config|
      config.rethinkdb_url          = "rethinkdb://localhost/rethink_benchmarks"
      config.logger                 = nil
      config.warn_on_active_record  = true
      #config.auto_create_database   = true
      config.auto_create_tables     = true
      config.cache_documents        = true
      config.max_reconnection_tries = 10
      config.durability             = :soft
    end
  end

  def title
    'NoBrainer'
  end

  def setup
    NoBrainerPost.delete_all
  end

  def insert(attrs)
    post = NoBrainerPost.create! attrs
    post.id
  end

  def read(id)
    NoBrainerPost.find id
  end

  def update(id, attrs)
    post = NoBrainerPost.find id
    post.update_attributes attrs
  end

end