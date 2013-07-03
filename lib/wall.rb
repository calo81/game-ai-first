class Wall
  attr_reader :lines
  def initialize(window, lines)
    @lines = lines
    @wall_image = TexPlay.create_image(window, TexPlay::TP_MAX_QUAD_SIZE, 768, {:color => :alpha, :caching => true})
  end
  
  def is_wall_here?(position)
    @wall_image.get_pixel(position[0],position[1])[1] == 1.0
  end
  
  def draw
    the_wall = self
    @wall_image.paint do
      the_wall.lines.each do |wall|
        line wall.from.x, wall.from.y, wall.to.x, wall.to.y, :thickness => 5, :color => :green  
      end     
    end
    @wall_image.draw(0,0,0)
  end
end