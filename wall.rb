require_relative './shared.rb'
class Wall
  WALL_HEIGHT = 12
  COLOR = 'white'
  Z_INDEX = 0
  DOWN_P1 = 'down'
  UP_P1 = 'up'
  DOWN_P2 = 's'
  UP_P2 = 'w'
  PIXEL_INCREMENTS = 5
  OUT_OF_BOUND_ALLOWANCE = 20

  def initialize(
    graphical_initalizer,
    window_length,
    window_height,
    side
  )
    @representation = graphical_initalizer.new(
      x:  0 , y:  side == 'top' ? - OUT_OF_BOUND_ALLOWANCE : window_height - WALL_HEIGHT,
      width: window_length, height:  WALL_HEIGHT + OUT_OF_BOUND_ALLOWANCE,
      color: COLOR,
      z:  Z_INDEX
    )
    @side = side
  end


  def left(ball_x_position)
    ball_x_position > @representation.x &&  ball_x_position < @representation.width/2
  end

  def right(ball_x_position)
    ball_x_position > @representation.x  + @representation.width/2 &&  ball_x_position <= @representation.x  + @representation.width
  end

  def get_direction(current_direction,ball_position)
    if @side == 'top'
      if     left(ball_position[0][0])
        return  Direction::SW if current_direction == Direction::NW
        return  Direction::SE
      elsif  right(ball_position[0][0])
        return  Direction::SW if current_direction == Direction::NW
        return  Direction::SE
      else
        return Direction::S
      end
    else
      if  left(ball_position[0][0])
        return  Direction::NW if current_direction == Direction::SW
        return  Direction::NE
      elsif  right(ball_position[0][0])
        return  Direction::NW if current_direction == Direction::SW
        return  Direction::NE
      else
        return Direction::N
      end
    end
  end


  def check_if_hit(ball)
    ball_position = ball.detectable_position
    @representation.contains? ball_position[0][0],ball_position[0][1]
  end

end
