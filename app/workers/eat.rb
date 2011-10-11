# -*- encoding : utf-8 -*-
class Eat
  @queue = :food

  def self.perform(food)
    puts "Ate #{food}!" + " #{Time.now}"
  end
end
