require "#{__FILE__}/../drawable_character"
require "#{__FILE__}/../event_handler"
class AICharacter < DrawableCharacter

  def seek_and_arrive(target)
    @moving = true
    @position += @velocity * @time_update
    @velocity =  target.position - position
    if  @velocity.magnitude < target.radius
      EventHandler::add_event(:capture,self,target)
    end
    @velocity = @velocity.normalize
    @velocity *= @max_speed
    @orientation = @velocity.normalize
  end
  
  def avoid_obstacles
  end
end