
# base class for benchmark runners
class Runner

  def self.insert_num
    1000
  end

  def self.update_nun
    1000
  end

  def self.read_num
    1000
  end

  attr_accessor :insert_time, :read_time, :update_time, :insert_num, :read_num, :update_num

  def initialize
    @insert_num = Runner.insert_num
    @update_num = Runner.update_nun
    @read_num = Runner.read_num
  end

  def timed_run(&block)
    start_time = Time.now
    yield block
    (Time.now - start_time).to_f
  end

  def run
    setup
    puts ":: #{title} ::"
    print_version

    @insert_time = timed_run {run_insert}
    puts "Total insert time: #{@insert_time.round(2)} seconds (#{(@insert_num/@insert_time).round(1)} inserts/second)"

    @read_time = timed_run {run_read}
    puts "Total read time: #{@insert_time.round(2)} seconds (#{(@read_num/@read_time).round(1)} reads/second)"

    @update_time = timed_run {run_update}
    puts "Total update time: #{@update_time.round(2)} seconds (#{(@update_num/@update_time).round(1)} updates/second)"

    puts ''
  end

  def percent(num)
    "#{(num * 100.0).round(1)}%"
  end

  def compare_to(other)
    puts "#{title} performs inserts at #{percent(other.insert_time/@insert_time)}, reads at #{percent(other.read_time/@read_time)}, and updates at #{percent(other.update_time/@update_time)} the speed of #{other.title}."
    puts ''
  end

  protected

  def print_version

  end

  def title
    raise 'Subclasses should override'
  end

  def setup
    raise 'Subclasses should override'
  end

  def insert(attrs)
    raise 'Subclasses should override'
  end

  def run_insert
    body = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    date = Time.now
    @ids = []
    0.upto(@insert_num) do |i|
      @ids << insert(title: "Post #{i}", body: body, posted_at: date + i.days)
    end
  end

  def read(id)
    raise 'Subclasses should override'
  end

  def run_read
    0.upto(@insert_num) do |i|
      read @ids.sample
    end
  end

  def update(id, attrs)
    raise 'Subclasses should override'
  end

  def run_update
    body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    0.upto(@update_num) do |i|
      update @ids.sample, {title: "Updated post #{i}", body: body}
    end
  end

end