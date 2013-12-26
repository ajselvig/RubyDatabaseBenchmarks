require './runner'
require 'rethinkdb'
include RethinkDB::Shortcuts

class RethinkRunner < Runner

  @@DB_NAME = 'rethink_benchmarks'

  def initialize
    super
    @conn = r.connect(:host => 'localhost',
                      :port => 28015,
                      :db => @@DB_NAME)
  end

  def print_version
    puts '* ' + (`rethinkdb -v`).gsub("\n", '') + ' (durability: soft)'
  end

  def title
    'RethinkDB'
  end

  def setup
    begin
      r.db_create(@@DB_NAME).run(@conn)
      r.db(@@DB_NAME).table_create('posts').run(@conn)
    rescue
      # I don't really care if these fail
    end
  end

  def insert(attrs)
    time = Time.now
    attrs[:created_at] = time
    attrs[:updated_at] = time
    result = r.db(@@DB_NAME).table('posts').insert(attrs).run(@conn, durability: "soft")
    result['generated_keys']
  end

  def read(id)
    r.db(@@DB_NAME).table('posts').get(id).run(@conn)
  end

  def update(id, attrs)
    time = Time.now
    attrs[:updated_at] = time
    result = r.db(@@DB_NAME).table('posts').get(id).update(attrs).run(@conn)
  end

end