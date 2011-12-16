require "#{__FILE__}/../drawable_character"
class ControllableCharacter < DrawableCharacter
  def move(side)
    @character.move_ahead if side==:front
    change_velocity_according_to_side(side)
  end

  def change_velocity_according_to_side(side)
    return if side == :front
    if side == :right
      sin_radians = Math::sin 0.1
      cos_radians = Math::cos 0.1
    else
     sin_radians = Math::sin -0.1
     cos_radians = Math::cos -0.1
    end
    velocity_x = @character.velocity[0]*cos_radians - @character.velocity[1]*sin_radians
    velocity_y = @character.velocity[0]*sin_radians + @character.velocity[1]*cos_radians
    @character.velocity = Vector[velocity_x,velocity_y]
    @character.velocity = @character.velocity.normalize * (@character.max_speed+1)
  end
end