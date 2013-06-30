class Point
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end
end

class Line
  attr_reader :from, :to
  def initialize(from,to)
    @from = from
    @to = to
  end
end