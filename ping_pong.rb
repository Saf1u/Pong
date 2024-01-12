class PingPong
  require 'ruby2d'
  require_relative './shared.rb'

  RADIUS = 7
  SECTOR = 32
  COLOR = 'white'
  Z_INDEX = 10
  DELTA = [-15,+15]
  DIRECTION = [Direction::W,Direction::E]
  def initialize(graphical_initalizer,start_x_position,start_y_position)
    @object = graphical_initalizer.new(
      x: start_x_position, y: start_y_position-120,
      size: RADIUS,
      color: COLOR,
      z: Z_INDEX
    )
    @direction_index = 0
    @delta_index = 0
    @sound = Sound.new('beeep.mp3')
    @direction = Direction::SW
    @start_position_x = @object.x
    @start_position_y = @object.y
  end

  def recenter
    @object.x = @start_position_x
    @object.y = @start_position_y
  end

  def move(objects)

    case  @direction
    when  Direction::N
      @object.y-=10
    when  Direction::W
      @object.x-=10
    when  Direction::E
      @object.x+=10
    when  Direction::S
      @object.y+=10
    when  Direction::NE
      @object.x+=10 + rand(1...6)
      @object.y-=10 + rand(1...6)
    when  Direction::NW
      @object.y-=10 + rand(1...6)
      @object.x-=10 + rand(1...6)
    when  Direction::SW
      @object.y+=10 + rand(1...6)
      @object.x-=10 + rand(1...6)
    when  Direction::SE
      @object.y+=10 + rand(1...6)
      @object.x+=10 + rand(1...6)
    else
      exit
    end

    return out_of_bounds_side if out_of_bounds_side

    pos = detectable_position
    objects.each do |object|
      hit =  object.check_if_hit(self)
      @direction = object.get_direction(@direction,pos) if hit
      @sound.play if hit
    end
    nil
  end

  def detectable_position
      return [[@object.x , @object.y] ,[@object.x  , @object.y] ]
  end

  def out_of_bounds_side
    return 'left' if @object.x < 0
    return 'right' if @object.x  > Window.width
    nil
  end
end
