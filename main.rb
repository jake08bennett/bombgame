require "gosu"
require_relative 'player'
require_relative 'bomb'
require_relative 'bullet'
require_relative 'zorder'


class GameWindow < Gosu::Window


  def initialize
    super 640, 480, false
    self.caption = "d trump"
    @background_image = Gosu::Image.new(self, "media/space.jpg", true)
    @player = Player.new(self)
    @player.warp(320, 240)
    @star_anim = Gosu::Image::load_tiles(self, "media/trump.png", 25, 25, false)
    @stars = Array.new
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @bullets = []
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::KbA then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::KbD then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::KbW then
      @player.accelerate_forwards
    end
    if button_down? Gosu::KbDown or button_down? Gosu::KbS then
      @player.accelerate_backwards
    end
    if button_down? Gosu::KbSpace then
      @bullets << @player.shoot(self)
    end
    
    @player.move
    @player.collect_stars(@stars)
    

    if rand(100) < 4 and @stars.size < 10 then
      @stars.push(Star.new(@star_anim))
    end
  end

  def draw
    theScore = 0
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Lives: #{@player.lives}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Score: #{theScore}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @bullets.each do |bullet|
      bullet.update
      bullet.draw
      bullet.collide(@stars)
      if bullet.collide(@stars)
        theScore += 1
      end
    end
  end
  
   def button_down(id)
    if id == Gosu::KbEscape 
      close
    end
  end
end

window = GameWindow.new
window.show

