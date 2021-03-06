require "gosu"
require_relative 'zorder'

class Bullet

  def initialize(window, angle)
    @image = Gosu::Image.new(window, "media/trump.png", false)
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = angle
    @score = 0
  end
  
  def warp(x, y)
    @x, @y = x, y
  end
  
  def accelerate_forwards
    @vel_x += Gosu::offset_x(@angle + 90, 0.25)
    @vel_y += Gosu::offset_y(@angle + 90, 0.25)
  end
  
   def move
    @x += @vel_x
    @y += @vel_y

    @vel_x *= 0.95
    @vel_y *= 0.95
  end
  
  def update
    accelerate_forwards
    move
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, 0.0)
  end

  def collide(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35 then
        true
        @score += 1
      else
        false
      end
    end
  end

  def score
    @score
  end
  
end