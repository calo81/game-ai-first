require_relative "kinematic"

module Direction
  LEFT = 1
  UP = 3
  DOWN = 0
  RIGHT = 2
  UP_LEFT = 6
  DOWN_LEFT = 4
  UP_RIGHT = 7
  DOWN_RIGHT = 5
end

class DrawableCharacter
  include Kinematic

  attr_reader :moving
  

  def initialize(window, character_img, position_x, position_y)
    init_kinematic(window, position_x, position_y)
    @sprite_sheet = Gosu::Image::load_tiles(window, character_img, 32, 32, false)
    @last_sprite_index = 0
    @max_sprite_x = 5
    @max_sprite_y = 7
    @frames_to_update_sprite = 2
    @current_frame_count = 0
    @last_sprite_direction = 0
    @window = window
  end

  def draw
    establish_character_draw_direction
    @current_frame_count += 1
    @current_frame_count = 0 if @current_frame_count > @frames_to_update_sprite
    image = @sprite_sheet[@last_sprite_index + 6*@last_sprite_direction]
    if (moving and @current_frame_count == @frames_to_update_sprite)
      @last_sprite_index += 1
      @last_sprite_index = 0 if @last_sprite_index > @max_sprite_x
    end
    image.draw_rot(position[0], position[1], 1, orientation_in_radians)
  end
  
  private
  
  def establish_character_draw_direction
    absolute_orientation = orientation_in_radians.abs
    if (orientation_in_radians < (-1.14) and orientation_in_radians > (-1.9))
      @last_sprite_direction = Direction::RIGHT
    elsif (absolute_orientation > (0.18) and absolute_orientation < (0.31))
      @last_sprite_direction = Direction::DOWN
    elsif ((absolute_orientation < (3.0) and absolute_orientation > (2.8)))
      @last_sprite_direction = Direction::UP
    elsif ((orientation_in_radians < (1.9) and orientation_in_radians > (1.14)))
      @last_sprite_direction = Direction::LEFT
    elsif ((orientation_in_radians < (2.8) and orientation_in_radians > (1.9)))
      @last_sprite_direction = Direction::UP_LEFT
    elsif ((orientation_in_radians < (1.14) and orientation_in_radians > (0.31)))
      @last_sprite_direction = Direction::DOWN_LEFT
    elsif ((orientation_in_radians < (-1.9) and orientation_in_radians > (-3.0)))
      @last_sprite_direction = Direction::UP_RIGHT
    elsif ((orientation_in_radians < (0.18) and orientation_in_radians > (-1.14)))
      @last_sprite_direction = Direction::DOWN_RIGHT
    end
  end
end