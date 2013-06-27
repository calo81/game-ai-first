require_relative "kinematic"
class DrawableCharacter
  include Kinematic
  
  attr_reader :moving
  
  def initialize(window,character_img, position_x, position_y)
    init_kinematic(position_x, position_y)
    @sprite_sheet = Gosu::Image::load_tiles(window, character_img, 32, 32, false)
    @last_sprite_index = 0
    @max_sprite_x = 5
    @max_sprite_y = 7
    @frames_to_update_sprite = 10
    @current_frame_count = 0
  end

  def draw
    @current_frame_count += 1
    @current_frame_count = 0 if @current_frame_count > @frames_to_update_sprite
    image = @sprite_sheet[@last_sprite_index]
    if(moving and @current_frame_count == @frames_to_update_sprite)
      @last_sprite_index += 1 
      @last_sprite_index = 0 if @last_sprite_index > @max_sprite_x
    end
    image.draw_rot(position[0], position[1], 1, orientation_in_radians)
  end
end