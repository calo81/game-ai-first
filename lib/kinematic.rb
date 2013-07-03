require "matrix"
require_relative "collision_detector"
module Kinematic
  attr_accessor :velocity, :orientation, :position, :max_speed, :time_update
  def init_kinematic(window, position_x,position_y)
    @velocity = Vector[5,5]
    @orientation = @velocity.normalize
    @position = Vector[position_x,position_y]
    @max_speed = 8
    @time_update = 0.4
    @velocity = @velocity.normalize * @max_speed
    @lookahead = 10
    @avoid_distance = 5
    @collision_detector = CollisionDetector.new(window.walls)
  end

  def orientation_in_radians
    Math::atan2(-@velocity[0], @velocity[1])
  end
end