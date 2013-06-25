require 'gosu'
require_relative "drawable_character"
require_relative "controllable_character"
require_relative "ai_character"
require_relative "target"
require_relative "character"
require_relative "event_handler"

class Game < Gosu::Window

  def initialize
    super 1024, 768, false
    self.caption = "Wolfenstein"
    @target = ControllableCharacter.new(Target.new(10, 10), self, 'assets/target.gif')
    @character1 = AICharacter.new(Character.new(500, 500), self, 'assets/character.gif')
    @game_state = :game_started
  end

  def manage_ai_characters
    @character1.seek_and_arrive(@target.character)
  end

  def manage_controllable_character
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @target.move :left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @target.move :right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @target.move :front
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