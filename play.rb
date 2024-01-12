require 'ruby2d'
require_relative './paddle.rb'
require_relative './ping_pong.rb'
require_relative './shared.rb'
require_relative './wall.rb'

set title: "shinderu pong"

PLAYER_ONE_SCORE_POSITION  = [Window.width/2 - 200,Window.height/2 -100]
PLAYER_TWO_SCORE_POSITION  = [Window.width - 200,Window.height/2 -100]
def new_score(x_position,y_position,score)
  Text.new(
    score,
    x: x_position, y: y_position,
    style: 'bold',
    size: 40,
    color: 'white',
    rotate: 0,
    z: 10
  )
end
player_one_score = new_score(PLAYER_ONE_SCORE_POSITION[0],PLAYER_ONE_SCORE_POSITION[1],0)

player_two_score = new_score(PLAYER_TWO_SCORE_POSITION[0],PLAYER_TWO_SCORE_POSITION[1],0)


score_sound = Sound.new('SHINDERU.mp3')
Line.new(
  x1: Window.width/2, y1: 0,
  x2: Window.width/2, y2: Window.height,
  width: 5,
  color: 'white',
  z: 20
)



paddle_one  = Paddle.new(Player::ONE,Rectangle,0,0,0,Window.height,'left')
paddele_two = Paddle.new(Player::TWO,Rectangle,Window.width-Paddle::PADDLE_WIDTH,0,0,Window.height,'right')
ball = PingPong.new(Square,Window.width/2,Window.height/2)
wall_top = Wall.new(Rectangle,Window.width,Window.height,'top')
wall_bottom = Wall.new(Rectangle,Window.width,Window.height,'bottom')
paddles = [paddle_one,paddele_two]
Thread.new do

  loop do
    sleep 0.0000000000001
    side = ball.move([*paddles,wall_top,wall_bottom])
    if side =='left' || side == 'right'
      score_sound.play
      sleep 4
      ball.recenter

      if side == 'right'
        player_one_score.remove
        score =  player_one_score.text.to_i + 1
        player_one_score = new_score(PLAYER_ONE_SCORE_POSITION[0],PLAYER_ONE_SCORE_POSITION[1],score)
      else
        player_two_score.remove
        score =  player_two_score.text.to_i + 1
        player_two_score = new_score(PLAYER_TWO_SCORE_POSITION[0],PLAYER_TWO_SCORE_POSITION[1],score)
      end
    end
  end
end



on :key_held do |event|
paddles.each do |paddle|
  paddle.receive_action(event.key)
 end
end
show

