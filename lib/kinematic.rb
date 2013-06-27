require "matrix"
module Kinematic
  attr_accessor :velocity, :orientation, :position, :max_speed, :time_update
  def init_kinematic(position_x,position_y)
    @velocity = Vector[5,5]
    @orientation = @velocity.normalize
    @position = Vector[position_x,position_y]
    @max_speed = 2
    @time_update = 0.4
    @velocity = @velocity.normalize * @max_speed
  end

  def orientation_in_radians
    Math::atan2(-@velocity[0], @velocity[1])
  end
end