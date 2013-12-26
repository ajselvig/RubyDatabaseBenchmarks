require 'mongoid'
require './runner'

class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :body, type: String
  field :posted_at, type: Date
end


class MongoidRunner < Runner

  def initialize
    super
    Mongoid.load!("mongoid.yml", :development)
  end

  def title
    'Mongoid'
  end

  def setup
    Post.delete_all
  end

  def insert(attrs)
    Post.create! attrs
  end

  def read(id)
    Post.find id
  end

  def update(id, attrs)
    post = Post.find id
    post.update_attributes attrs
  end

end
