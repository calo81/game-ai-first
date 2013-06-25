require "#{__FILE__}/../drawable_character"
class AICharacter < DrawableCharacter
  def seek_and_arrive(target)
    @character.seek_and_arrive(target)
  end
end