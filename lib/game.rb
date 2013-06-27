require 'gosu'
require_relative "drawable_character"
require_relative "controllable_character"
require_relative "ai_character"
require_relative "event_handler"

class Game < Gosu::Window

  def initialize
    super 1024, 768, false
    self.caption = "Wolfenstein"
    @target = ControllableCharacter.new(self, 'assets/character_sprite_sheet.png', 10, 10)
    @character1 = AICharacter.new(self, 'assets/character_sprite_sheet.png', 500, 500)
    @game_state = :game_started
  end

  def manage_ai_characters
    @character1.seek_and_arrive(@target)
  end

  def manage_controllable_character
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft 
      @target.move :left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight 
      @target.move :right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 
      @target.move :front
    end
    if !(button_down? Gosu::KbUp or button_down? Gosu::GpButton0) and !(button_down? Gosu::KbRight or button_down? Gosu::GpRight) and !(button_down? Gosu::KbLeft or button_down? Gosu::GpLeft)
      @target.not_moving
    end
  end

  def manage_events
    EventHandler::each do |event|
      if event[0]==:capture
        @game_state = :game_over
      end
    end
  end

  def update
    manage_events
    if @game_state != :game_over
      manage_ai_characters()
      manage_controllable_character()
    end
  end

  def draw
    if @game_state != :game_over
      @target.draw
      @character1.draw
    else
      Gosu::Image.new(self, "assets/game_over.gif", true).draw(0, 0, 0);
    end
  end
end