require "#{__FILE__}/../drawable_character"
require "#{__FILE__}/../event_handler"
class AICharacter < DrawableCharacter

  def seek_and_arrive(target)
    target_position = target.position
    collision_target = get_collision
    target_position = collision_target if collision_target
    @moving = true
    @position += @velocity * @time_update
    @velocity =  target_position - position
    if  @velocity.magnitude < target.radius
      #EventHandler::add_event(:capture,self,target)
    end
    @velocity = @velocity.normalize
    @velocity *= @max_speed
    @orientation = @velocity.normalize
  end
  
  def get_collision
    ray_vector=@velocity
    ray_vector.normalize()
    ray_vector *= @lookahead
    collision=@collision_detector.get_collision(@position,ray_vector)
    return (collision.position + collision.normal) * @avoid_distance if collision      
  end
end