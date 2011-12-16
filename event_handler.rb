require 'thread'
class EventHandler

  def self.add_event(*event)
    @queue ||= Queue.new
    @queue.push(event)
  end

  def self.each
    unless @queue.nil? || @queue.empty?
      yield @queue.pop
    end
  end
end