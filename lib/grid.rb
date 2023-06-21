# frozen_string_literal: true

class Grid
  attr_accessor :positions

  def initialize(row, col)
    @positions = new_grid(row, col)
  end

  def new_grid(row, col)
    Array.new(row) { Array.new(col, '-') }
  end

  def show
    puts '▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄'
    puts '▌                     ▐'
    @positions.reverse.each do |row|
      puts "▌ #{row.join('  ')} ▐"
      puts '▌                     ▐'
    end
    puts '▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀'
    puts '  1  2  3  4  5  6  7  '
  end

  def update(choice, circle)
    col = confirm_col(choice).to_i
    @positions.each do |row|
      next unless row[col - 1] == '-'

      row[col - 1] = circle
      show
      break
    end
  end

  def confirm_col(choice)
    until (1..7).to_a.include?(choice.to_i)
      puts 'Error: Only enter a valid column number [1-7]'
      choice = gets.chomp
    end
    until @positions.any? { |row| row[choice.to_i - 1] == '-' }
      puts 'Error: Column full, choose another [1-7]'
      choice = gets.chomp
    end
    choice
  end

  def full?
    @positions.flatten.none?('-')
  end
end
