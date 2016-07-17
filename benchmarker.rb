
require_relative 'knight_search'

class Benchmarker

  def benchmark(repeats=1)
    t = Time.now
    repeats.times { yield }
    Time.now - t
  end

end

b = Benchmarker.new
times = 1000
dfs_result = b.benchmark(times){KnightSearcher.new(MoveTree.new([0,0], 5)).dfs_for([3,3])}
bfs_result = b.benchmark(times){KnightSearcher.new(MoveTree.new([0,0], 5)).bfs_for([3,3])}

puts "result for dfs is #{dfs_result} and result for bfs is #{bfs_result}"

