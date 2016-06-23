local lv = love
local g = lv.graphics

local dbg = true

local paddle_w = 40

local Paddle = {}
Paddle.new = function(x, y)
  local paddle = {}
  setmetatable(paddle, {__index = Paddle})
  paddle.x = x
  paddle.y = y
  paddle.w = paddle_w
  paddle.h = 100
  return paddle
end

function Paddle:draw()
  g.rectangle('fill', self.x, self.y, self.w, self.h)
end

local init = function()
  touches = {}
  output = ''
  win = {w = g.getWidth(), h = g.getHeight()}
  paddles = {Paddle.new(0, 0), Paddle.new(win.w - paddle_w, 0)}
end

local update = function(dt)
  for _, touch in pairs(touches) do
    if touch[1] < win.w / 2 then
      paddles[1].y = touch[2]
      break
    end
  end
  for _, touch in pairs(touches) do
    if win.w / 2 < touch[1] then
      paddles[2].y = touch[2]
      break
    end
  end
  
end

local draw = function()
  for _, p in ipairs(paddles) do
    p:draw()
  end
  if dbg then
    g.print(output)
    for _, loc in pairs(touches) do
      g.circle('line', loc[1], loc[2], 100, 16)
    end
  end
end

local on_touch = function(id, x, y)
  touches[id] = {x, y}
end

local on_release = function(id)
  touches[id] = nil
end

local on_slide = function(id, x, y)
  touches[id] = {x, y}
end

lv.load = init
lv.update = update
lv.draw = draw
lv.touchpressed = on_touch
lv.touchreleased = on_release
lv.touchmoved = on_slide
