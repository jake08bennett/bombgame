require "gosu"
require_relative 'zorder'


class Player

  attr_reader :score, :lives
  
  def initialize(window)
    @image = Gosu::Image.new(window, "media/trump.png", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @lives = 5
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end
  
  def shoot(window)
    bullet = Bullet.new(window, @angle)
    bullet.warp(@x, @y)
    bullet
  end

  def accelerate_forwards
    @vel_x += Gosu::offset_x(@angle + 90, 0.25)
    @vel_y += Gosu::offset_y(@angle + 90, 0.25)
  end
  
  def accelerate_backwards
    @vel_x -= Gosu::offset_x(@angle + 90, 0.25)
    @vel_y -= Gosu::offset_y(@angle + 90, 0.25)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
  
  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 35 then
        @lives -= 1
        close if @lives == 0
        true
      else
        false
      end
    end
	end

  def score
    @score
  end
  
end