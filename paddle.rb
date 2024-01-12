require_relative './shared.rb'
class Paddle
  PADDLE_WIDTH = 20
  PADDLE_HEIGHT = 150
  COLOR = 'white'
  Z_INDEX = 10
  DOWN_P1 = 'down'
  UP_P1 = 'up'
  DOWN_P2 = 's'
  UP_P2 = 'w'
  PIXEL_INCREMENTS = 5
  ALLOWANCE = 16

  def initialize(
    player,
    graphical_initalizer,
    start_x_position,
    start_y_position,
    min_horizontal_span,
    max_horizontal_span,
    side)
    @representation = graphical_initalizer.new(
      x: start_x_position, y: start_y_position,
      width: PADDLE_WIDTH, height: PADDLE_HEIGHT,
      color: COLOR,
      z:  Z_INDEX
    )
    @min_horizontal_span = min_horizontal_span
    @max_horizontal_span = max_horizontal_span
    @side = side
    @up = player == Player::ONE ? UP_P1 : UP_P2
    @down = player == Player::ONE ? DOWN_P1 : DOWN_P2
    @player = player
  end

  def receive_action(action)
    if action ==DOWN_P1 && @player == Player::ONE || action == DOWN_P2 && @player == Player::TWO
      move_down
    elsif  action == UP_P1 && @player == Player::ONE || action == UP_P2 && @player == Player::TWO
      move_up
    else
      return
    end

  end


  def top(ball_y_position)
    ball_y_position > @representation.y &&  ball_y_position  < @representation.y  + (PADDLE_HEIGHT/2)
  end

  def bottom(ball_y_position)
    ball_y_position  > @representation.y  + (PADDLE_HEIGHT/2) &&  ball_y_position <= @representation.y  + PADDLE_HEIGHT
  end


  def get_direction(current_direction,ball_position)
    if @side == 'left'
      if top(ball_position[0][1])
        return Direction::NE
      elsif  bottom(ball_position[0][1])
        return Direction::SE
      else
        return Direction::E
      end
    else
      if  top(ball_position[0][1])
        return Direction::NW
      elsif  bottom(ball_position[0][1])
        return Direction::SW
      else
        return Direction::W
      end
    end
  end

  def check_if_hit(ball)
    ball_position = ball.detectable_position
    @representation.contains? ball_position[0][0],ball_position[0][1]
  end


  private

  def move_down
    if @representation.y+PIXEL_INCREMENTS+PADDLE_HEIGHT >=  @max_horizontal_span
      @representation.y =  @max_horizontal_span - PADDLE_HEIGHT
    else
      @representation.y+=PIXEL_INCREMENTS
    end
  end

  def move_up
    if @representation.y-PIXEL_INCREMENTS <=0
      @representation.y = @min_horizontal_span
    else
      @representation.y-=PIXEL_INCREMENTS
    end
  end

end
