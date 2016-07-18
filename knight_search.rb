require 'pry'
require_relative 'move_tree'

class KnightSearcher

  def initialize(tree)
    @root = tree.root

  end

  def bfs_for(target_coords)
    queue = []
    queue << @root
    until queue.empty?
      current_node = queue.pop
      if [current_node.x, current_node.y] == [target_coords[0], target_coords[1]]
        display_solution(current_node)
        break
      else
        current_node.children.each { |child| queue.unshift(child) }
      end
      puts "Move not found" if queue.empty?
    end

  end

  def dfs_for(target_coords)
    stack = []
    stack << @root
    until stack.empty?
      current_node = stack.pop
      if [current_node.x, current_node.y] == [target_coords[0], target_coords[1]]
        display_solution(current_node)
        break
      else
        current_node.children.each { |child| stack.push(child) }
      end
    end
    puts "Move not found" if stack.empty?
  end



  def display_solution(node)
    moves_seq = []
    puts "Depth is #{node.depth}"
    moves_seq << [node.x, node.y]
    while node.parent
      moves_seq << [node.parent.x, node.parent.y]
      node = node.parent
    end
    moves_seq.reverse.each do |move|
      print "#{move}\n"

    end

  end
end

tree = MoveTree.new([3,3], 7)

searcher = KnightSearcher.new(tree)
# p searcher.bfs_for([1,3])

p searcher.dfs_for([1,3])
