local Kaizer = {}
local EnemyCars = {}

--function to detect collision between Kaizer (player) and Cars. Inputs are
--ax = topleft x coordinate of first object A (car), ay = topleft y coordinate of object A,
--aw = width of object A, ah = height of object A,
--bx = topleft x coordinate of first object B (Kaizer), by = topleft y coordinate of object B,
--bw = width of object B, bh = height of object B,
local function collision (ax, ay, aw, ah, bx, by, bw, bh)
  return ay < by + bh and
  ay + ah > by and
  ax + aw > bx and
  ax < bx + bw
end

function love.load()
  local imageKaizer = love.graphics.newImage("assets/Kaizer.jpg")
  local imageCar1 = love.graphics.newImage("assets/Car1.jpg")
  local imageCar2 = love.graphics.newImage("assets/Car2.jpg")
  local imageCar3 = love.graphics.newImage("assets/Car3.jpg")

  local car1 = {
    img = imageCar1,
    x = 0, y = 100, w = imageCar1:getWidth(), h = imageCar1:getHeight(),
    speed = 500, initialx = 0, endx = 1000
  }
  local car2 = {
      img = imageCar2,
      x = 1000, y = 200, w = imageCar2:getWidth(), h = imageCar2:getHeight(),
      speed = -500, initialx = 1000, endx = 1000
  }
  local car3 = {
      img=imageCar3,
      x=0, y=300, w=imageCar3:getWidth(), h=imageCar3:getHeight(),
      speed = 300, initialx = 0, endx = 1000
  }
  local car4 = {
      img = imageCar1,
      x = 2000, y = 400, w = imageCar1:getWidth(), h = imageCar1:getHeight(),
      speed = -700, initialx = 2000, endx = 2000
  }
  local car5 = {
      img=imageCar2,
      x=0, y=500, w=imageCar2:getWidth(), h=imageCar2:getHeight(),
      speed = -100, initialx = 1000, endx = 2000
  }
  local car6 = {
      img=imageCar3, x=0, y=600, w=imageCar3:getWidth(), h=imageCar3:getHeight(),
      speed = 400, initialx = 0, endx = 1000
  }

  Kaizer = {
      img=imageKaizer,
      x=200, y=0, w=imageKaizer:getWidth(), h=imageKaizer:getHeight(),
      speed = 500
  }
  EnemyCars = {car1, car2, car3, car4, car5, car6}
end

function love.update(dt)
  for car in pairs(EnemyCars) do
    car.x = car.x + car.speed * dt
    if car.x > car.endx or car.x < 0 then
      car.x = car.initialx
      --table.remove(EnemyCars, i)
    end
  end

  if love.keyboard.isDown("up") then
    Kaizer.y = Kaizer.y - Kaizer.speed * dt -- this would increment num by 100 per second
  end
  if love.keyboard.isDown("down") then
    Kaizer.y = Kaizer.y + Kaizer.speed * dt -- this would increment num by 100 per second
  end
  if love.keyboard.isDown("left") then
    Kaizer.x = Kaizer.x - Kaizer.speed * dt -- this would increment num by 100 per second
  end
  if love.keyboard.isDown("right") then
    Kaizer.x = Kaizer.x + Kaizer.speed * dt -- this would increment num by 100 per second
  end

end

function love.draw()
  love.graphics.print(tonumber(Kaizer.x), 0, 10)
  love.graphics.print(tonumber(Kaizer.y), 0, 20)

  love.graphics.draw(Kaizer.img, Kaizer.x, Kaizer.y)
  for car in pairs(EnemyCars) do
    love.graphics.draw(car.img, car.x, car.y)
  end

  for car in pairs(EnemyCars) do
    if collision(car.x, car.y, car.w, car.h, Kaizer.x, Kaizer.y, Kaizer.w, Kaizer.h) then
      love.graphics.print("COLLISION DETECTED", 0, 50)
    end
  end
end
