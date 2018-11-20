local Kaizer = {}
local EnemyCars = {}
local EnemyTraps = {}
local deathcounter=0

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

--function to make player character move in grid instead of smoothly. Initial positions
--and grid movement set to be in middle of road to increase difficulty. To do this, speed
--set to 100 to increment to be in middle of road, and initial position to (400, 5).
function love.keypressed(key)
  if key == "up" then
    Kaizer.y = Kaizer.y - Kaizer.speed
  end
  if key == "down" then
    Kaizer.y = Kaizer.y + Kaizer.speed
  end
  if key == "left" then
    Kaizer.x = Kaizer.x - Kaizer.speed
  end
  if key == "right" then
    Kaizer.x = Kaizer.x + Kaizer.speed
  end
end

function love.load()
  local imageKaizer = love.graphics.newImage("assets/Kaizer.jpg")
  local imageCar1 = love.graphics.newImage("assets/Car1.jpg")
  local imageCar2 = love.graphics.newImage("assets/Car2.jpg")
  local imageCar3 = love.graphics.newImage("assets/Car3.jpg")
  local imagetrap1 = love.graphics.newImage("assets/Trap1.jpg")
  local imagetrap2 = love.graphics.newImage("assets/Trap2.jpg")

  local car1 = {
    img = imageCar1,
    x = 0, y = 50, w = imageCar1:getWidth(), h = imageCar1:getHeight(),
    speed = 500, initialx = 0, endx = 1000
  }
  local car2 = {
      img = imageCar2,
      x = 1000, y = 100, w = imageCar2:getWidth(), h = imageCar2:getHeight(),
      speed = -500, initialx = 1000, endx = 1000
  }
  local car3 = {
      img=imageCar3,
      x=0, y=150, w=imageCar3:getWidth(), h=imageCar3:getHeight(),
      speed = 300, initialx = 0, endx = 1000
  }
  local car4 = {
      img = imageCar1,
      x = 2000, y = 200, w = imageCar1:getWidth(), h = imageCar1:getHeight(),
      speed = -700, initialx = 2000, endx = 2000
  }
  local car5 = {
      img=imageCar2,
      x=0, y=250, w=imageCar2:getWidth(), h=imageCar2:getHeight(),
      speed = -100, initialx = 1000, endx = 2000
  }
  local car6 = {
      img=imageCar3, x=0, y=300, w=imageCar3:getWidth(), h=imageCar3:getHeight(),
      speed = 400, initialx = 0, endx = 1000
  }
  local car7 = {
    img = imageCar1,
    x = 0, y = 350, w = imageCar1:getWidth(), h = imageCar1:getHeight(),
    speed = 500, initialx = 0, endx = 1000
  }
  local car8 = {
      img = imageCar2,
      x = 1000, y = 400, w = imageCar2:getWidth(), h = imageCar2:getHeight(),
      speed = -500, initialx = 1000, endx = 1000
  }
  local car9 = {
      img=imageCar3,
      x=0, y=450, w=imageCar3:getWidth(), h=imageCar3:getHeight(),
      speed = 300, initialx = 0, endx = 1000
  }
  local car10 = {
      img = imageCar1,
      x = 2000, y = 500, w = imageCar1:getWidth(), h = imageCar1:getHeight(),
      speed = -700, initialx = 2000, endx = 2000
  }
  local car11 = {
      img=imageCar2,
      x=0, y=550, w=imageCar2:getWidth(), h=imageCar2:getHeight(),
      speed = -100, initialx = 1000, endx = 2000
  }
  local car12 = {
      img=imageCar3, x=0, y=600, w=imageCar3:getWidth(), h=imageCar3:getHeight(),
      speed = 400, initialx = 0, endx = 1000
  }

  local trap1 = {
    img=imagetrap2, x=250, y=200, w=imagetrap2:getWidth(), h=imagetrap2:getHeight()
  }
  local trap2 = {
    img=imagetrap2, x=250, y=300, w=imagetrap2:getWidth(), h=imagetrap2:getHeight()
  }
  local trap3 = {
    img=imagetrap1, x=100, y=500, w=imagetrap1:getWidth(), h=imagetrap1:getHeight()
  }
  local trap4 = {
    img=imagetrap1, x=400, y=500, w=imagetrap1:getWidth(), h=imagetrap1:getHeight()
  }
  local trap5 = {
    img=imagetrap2, x=100, y=550, w=imagetrap2:getWidth(), h=imagetrap2:getHeight()
  }

  Kaizer = {
      img=imageKaizer,
      x=400, y=5, w=imageKaizer:getWidth(), h=imageKaizer:getHeight(),
      speed = 50
  }
  EnemyCars = {car1, car2, car3, car4, car5, car6, car7, car8, car9, car10, car11, car12}
  EnemyTraps = {trap1, trap2, trap3, trap4, trap5}
end

function love.update(dt)
  for _, car in pairs(EnemyCars) do
    car.x = car.x + car.speed * dt
    if car.x > car.endx or car.x < 0 then
      car.x = car.initialx
      --table.remove(EnemyCars, i)
    end
  end
end

function love.draw()
  love.graphics.print(tonumber(Kaizer.x), 0, 10)
  love.graphics.print(tonumber(Kaizer.y), 0, 20)
  love.graphics.print(tonumber(deathcounter),100,70)
  love.graphics.print("deathcounter=",0,70)

  love.graphics.draw(Kaizer.img, Kaizer.x, Kaizer.y)
  for _, car in pairs(EnemyCars) do
    love.graphics.draw(car.img, car.x, car.y)
  end

  for _, car in pairs(EnemyCars) do
    if collision(car.x, car.y, car.w, car.h, Kaizer.x, Kaizer.y, Kaizer.w, Kaizer.h) then
      love.graphics.print("COLLISION DETECTED", 0, 50)
      deathcounter=deathcounter+1
    end
  end

  --code for spike traps or water that instantly kills player
  for _, trap in pairs(EnemyTraps) do
    love.graphics.draw(trap.img, trap.x, trap.y)
  end

  for _, trap in pairs(EnemyTraps) do
    if collision(trap.x, trap.y, trap.w, trap.h, Kaizer.x, Kaizer.y, Kaizer.w, Kaizer.h) then
      love.graphics.print("IT'S A TRAP. YOU ARE DEAD.", 0, 60)
      deathcounter=deathcounter+1
    end
  end

end