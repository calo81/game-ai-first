require "#{__FILE__}/../kinematic"
class Target
  include Kinematic
  def radius
     50
  end

  def move_ahead
    @position = @position + (@velocity*@time_update)
  end
end