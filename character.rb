require "#{__FILE__}/../event_handler"
class Character
  include Kinematic

  def seek_and_arrive(target)
    @position += @velocity * @time_update
    @velocity =  target.position - position
    if  @velocity.magnitude < target.radius
      EventHandler::add_event(:capture,self,target)
    end
    @velocity = @velocity.normalize
    @velocity *= @max_speed
    @orientation = @velocity.normalize
  end
end