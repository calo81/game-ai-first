require "#{__FILE__}/../drawable_character"
class ControllableCharacter < DrawableCharacter
    
  def radius
     50
  end

  def move_ahead
    @position = @position + (@velocity*@time_update)
  end
  
  def move(side)
    @moving = true
    move_ahead if side==:front
    change_velocity_according_to_side(side)
  end
  
  def not_moving
    @moving = false
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
    velocity_x = velocity[0]*cos_radians - velocity[1]*sin_radians
    velocity_y = velocity[0]*sin_radians + velocity[1]*cos_radians
    @velocity = Vector[velocity_x,velocity_y]
    @velocity = velocity.normalize * (max_speed+1)
  end
end