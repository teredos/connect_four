# frozen_string_literal: true

class Player
  attr_reader :name, :circle

  def create_name(player)
    puts "What is the name of Player #{player}?"
    @name = gets.chomp
  end

  def assign_circle(circle)
    @circle = circle
  end
end
