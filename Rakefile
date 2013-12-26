require './moped_runner'
require './mongoid_runner'
require './rethink_runner'
require './nobrainer_runner'

desc 'runs the benchmarks'
task :run do

  puts "Performing #{Runner.insert_num} inserts, #{Runner.read_num} reads, and #{Runner.update_nun} updates."

  puts `ruby -v`
  puts ''

  moped_runner = MopedRunner.new
  moped_runner.run

  mongoid_runner = MongoidRunner.new
  mongoid_runner.run

  moped_runner.compare_to mongoid_runner

  rethink_runner = RethinkRunner.new
  rethink_runner.run

  nobrainer_runner = NoBrainerRunner.new
  nobrainer_runner.run

  rethink_runner.compare_to nobrainer_runner

end