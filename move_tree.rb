# initialize a movetree with co-ords and max depth
# build tree
# create a queue
# add starting node to be co-ords and add depth to be 0
# pop from queue set as current node
# find valid moves for current node
# set as children, and add to queue with depth(parent's depth + 1), parent
# break if max depth reached


require 'pry'


Move = Struct.new(:x, :y, :depth, :children, :parent)

class MoveTree
  attr_reader :root
  def initialize(coordinates, max_depth)
    @root = Move.new(coordinates[0], coordinates[1], 1, [], nil)
    @max_depth = max_depth
    @board_max = 7
    @board_min = 0
    @count=1
    build_tree

  end

  def potential_moves(x, y)
    [
      [x+2, y-1],
      [x+2, y+1],
      [x-2, y-1],
      [x-2, y+1],
      [x+1, y-2],
      [x+1, y+2],
      [x-1, y-2],
      [x-1, y+2],
    ]
  end

  def invalid_coordinate?(input)
    input < @board_min || input > @board_max
  end

  def invalid_move?(x,y)
    invalid_coordinate?(x) || invalid_coordinate?(y)
  end

  def actual_move_coords(x,y)
    potential_moves(x, y).reject {|coordinates| invalid_move?(*coordinates)}
  end

  def build_tree
    queue = []
    queue << @root
    while queue.size > 0
      current_node = queue.pop
      actual_move_coords(current_node.x, current_node.y).each do |coords|
        node = Move.new(coords[0], coords[1], (current_node.depth)+1, [], current_node)
        @count += 1
        queue.unshift(node) unless node.depth >= @max_depth
        current_node.children << node
      end
    end
  end

  def inspect
    puts "Your tree has #{@count} Move nodes and a maximum depth of #{@max_depth}"
  end
end

# tree = MoveTree.new([3,3], 3)
# p tree.root
