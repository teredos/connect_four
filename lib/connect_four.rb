# frozen_string_literal: true

require_relative 'grid'
require_relative 'player'

class ConnectFour
  def initialize
    @grid = Grid.new(6, 7)
    @player1 = Player.new
    @player2 = Player.new
  end

  def start
    assign_names
    assign_circles
    @grid.show
    start_round(@player1)
  end

  def assign_names
    @player1.create_name(1)
    @player2.create_name(2)
  end

  def assign_circles
    puts "#{@player1.name}, would you like to play as the black circle or the white circle? [B/W]"
    choice = gets.chomp
    until %w[B W].include?(choice.upcase)
      puts "Error: Only input 'B' or 'W' (case insensitive)"
      choice = gets.chomp
    end
    @player1.assign_circle(choice.upcase == 'B' ? '○' : '●')
    @player2.assign_circle(choice.upcase == 'B' ? '●' : '○')
  end

  def start_round(player)
    puts "#{player.name}, which column would you like to place your #{player.circle} [1-7]?"
    @grid.update(gets.chomp, player.circle)
    if winner?(player.circle)
      puts "#{player.name} wins!"
    elsif @grid.full?
      puts "It's a tie!"
    else
      start_round(player == @player1 ? @player2 : @player1)
    end
  end

  def winner?(circle)
    horizontal_winner?(circle) || vertical_winner?(circle) || diagonal_winner?(circle)
  end

  def horizontal_winner?(circle)
    @grid.positions.any? { |row| row.join.include?(circle * 4) }
  end

  def vertical_winner?(circle)
    7.times do |i|
      column = []
      @grid.positions.each { |row| column << row[i] }
      return true if column.join.include?(circle * 4)
    end
    false
  end

  def diagonal_winner?(circle)
    k = 2
    3.times do
      i = k
      j = 0
      diagonal = []
      until i > 5
        diagonal << @grid.positions[i][j]
        i += 1
        j += 1
      end
      return true if diagonal.join.include?(circle * 4)

      k -= 1
    end

    k = 1
    3.times do
      i = 0
      j = k
      diagonal = []
      until j > 6
        diagonal << @grid.positions[i][j]
        i += 1
        j += 1
      end
      return true if diagonal.join.include?(circle * 4)

      k += 1
    end

    k = 3
    3.times do
      i = k
      j = 0
      diagonal = []
      until i.negative?
        diagonal << @grid.positions[i][j]
        i -= 1
        j += 1
      end
      return true if diagonal.join.include?(circle * 4)

      k += 1
    end

    k = 1
    3.times do
      i = 5
      j = k
      diagonal = []
      until j > 6
        diagonal << @grid.positions[i][j]
        i -= 1
        j += 1
      end
      return true if diagonal.join.include?(circle * 4)

      k += 1
    end
    false
  end
end
