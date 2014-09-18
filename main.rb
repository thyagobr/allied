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
    @board = Array.new(156)
    @players = params[:players]
  end

  def self.get_spawn_point(player)
    case player.color
    when :purple
      Board::SPAWN_POINT_PURPLE
    end
  end

  def set_new_match
    players.each { |player| set_position(Board.get_spawn_point(player)) }
    puts @board
  end

  def set_position(position)
    @board[position] = "P"
  end
end

class Main

  def game_loop
    @player = Player.new(:purple)
    @board = Board.new(players: [@player])
    @board.set_new_match
  end

end

m = Main.new
m.game_loop
