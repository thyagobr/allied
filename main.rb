require 'pry'

class Player
  attr_accessor :name, :color, :army

  def initialize(color)
    @color = color
    @army = []
    4.times.each { @army << Group.new }
  end

  class Group
    def pos
      @pos = @pos || 0
    end

    def pos=(value)
      @pos = value
    end

  end
end

class Board
  SPAWN_POINT_PURPLE = 0

  attr_accessor :board, :players

  def initialize(params)
    @board = Array.new(156, '#')
    @players = params[:players]
    @drawboard = Array.new
    20.times { @drawboard.push Array.new(20) }
  end

  def self.get_spawn_point(player)
    case player.color
    when :purple
      Board::SPAWN_POINT_PURPLE
    end
  end

  def set_new_match
    players.each { |player| set_position(Board.get_spawn_point(player)) }
  end

  def set_position(position)
    @board[position] = "P"
  end

  def draw_board
    # Board constant spaces
    @drawboard[0][0] = "&"
    @drawboard[0][1] = "&"
    @drawboard[0][2] = "&"
    @drawboard[1][0] = "&"
    @drawboard[1][1] = "&"
    @drawboard[1][2] = "&"
    @drawboard[2][0] = "&"
    @drawboard[2][1] = "&"
    @drawboard[2][2] = "&"
    @drawboard.each_with_index do |y, yi|
      y.each_with_index do |value, xi|
        if value.nil?
          print "#"
        else
          print value
        end
      end
      print "\n"
    end
    print "\n"
  end

  def board_position(pos)
    n = pos
    x = 0
    y = 0
    if n <= 3
      @drawboard[3][n]
      y, x = 3, n
    elsif n >= 4 and n <= 6
      @drawboard[2 - (n - 4)][3]
      y, x = 2 - (n - 4), 3
    elsif n >= 7 and n <= 18
      @drawboard[0][n - 3]
      y, x = 0, (n - 3)
    else
      @drawboard[n - 18][15]
      y, x = n - 18, 15
    end
    {:x => x, :y => y}
  end

  def set_player_position(player, new_pos)
    position = board_position(new_pos)
    puts "Position: #{position}"
    @drawboard[position[:y]][position[:x]] = "N"
    draw_board
  end
end

class Main

  def game_loop
    @player = Player.new(:purple)
    @board = Board.new(players: [@player])
    @board.set_new_match
    @board.draw_board
    @board.set_player_position(@player, 4)
    sleep(2)
    @board.set_player_position(@player, 10)
    sleep(3)
    @board.set_player_position(@player, 21)
  end

end

m = Main.new
m.game_loop
