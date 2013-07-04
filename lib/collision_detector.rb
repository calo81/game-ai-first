require 'segment'
require 'point'
require 'vector'
class Collision
  attr_reader :position, :normal
  def initialize(position, normal)
    @position = position
    @normal = normal
  end
end

class CollisionDetector
  
  def initialize(walls)
    @walls = walls
  end
  
  def get_collision(position, ray_vector)
   segment1 = Geometry::Segment.new_by_arrays([position[0], position[1]], [position[0] + ray_vector[0], position[0] + ray_vector[1]])
    @walls.lines.each do |line|
      segment2 = Geometry::Segment.new_by_arrays([line.from.x, line.from.y], [line.to.x, line.to.y])
      begin
        point_collision = segment1.intersection_point_with(segment2)
        perpendicular_vector = Vector[(line.to.y - line.from.y), -(line.to.x - line.from.x)]
        return Collision.new(Vector[point_collision.x,point_collision.y], perpendicular_vector)
      rescue Geometry::SegmentsDoNotIntersect
      end
    end
    nil
  end
end