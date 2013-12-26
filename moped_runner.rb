
require './mongoid_runner'


class MopedRunner < MongoidRunner

  def initialize
    super
    db = Mongoid::Sessions.default
    @posts = db['posts']
  end

  def print_version
    version = `mongod --version`
    puts '* ' + version.split("\n").first + ' (safe: true)'
  end

  def title
    'Moped'
  end

  def setup
    @posts.find().remove_all
  end

  def insert(attrs)
    time = Time.now
    attrs[:created_at] = time
    attrs[:updated_at] = time
    @posts.insert(attrs)
  end

  def read(id)
    @posts.find(_id: id)
  end

  def update(id, attrs)
    time = Time.now
    attrs[:updated_at] = time
    @posts.find(_id: id).update(attrs)
  end

end