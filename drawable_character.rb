class DrawableCharacter
  attr_reader :character
  def initialize(character,window,character_img)
     @image = Gosu::Image.new(window, character_img, false)
     @character = character
  end

  def draw
     @image.draw_rot(@character.position[0], @character.position[1], 1, @character.orientation_in_radians)
  end
end