Kaizer = {img=nil, x=200, y=0, w=0, h=0, speed=500}
EnemyCars = {}
imageKaizer = nil
imageCar1 = nil
imageCar2 = nil
imageCar3 = nil

function love.load()
  imageKaizer = love.graphics.newImage("assets/Kaizer.jpg")
  imageCar1 = love.graphics.newImage("assets/Car1.jpg")
  imageCar2 = love.graphics.newImage("assets/Car2.jpg")
  imageCar3 = love.graphics.newImage("assets/Car3.jpg")

  Kaizer = {img=imageKaizer, x=200, y=0, w=imageKaizer:getWidth(), h=imageKaizer:getHeight(), speed = 500}
  Car1 =  {img=imageCar1, x=0, y=100, w=imageCar1:getWidth(), h=imageCar1:getHeight(), speed = 500, initialx = 0, endx= 1000}
  table.insert(EnemyCars, Car1)
  Car2 = {img=imageCar2, x=1000, y=200, w=imageCar2:getWidth(), h=imageCar2:getHeight(), speed = -500, initialx = 1000, endx = 1000}
  table.insert(EnemyCars, Car2)
  Car3 = {img=imageCar3, x=0, y=300, w=imageCar3:getWidth(), h=imageCar3:getHeight(), speed = 300, initialx = 0, endx = 1000}
  table.insert(EnemyCars, Car3)
  Car4 =  {img=imageCar1, x=2000, y=400, w=imageCar1:getWidth(), h=imageCar1:getHeight(), speed = -700, initialx = 2000, endx= 2000}
  table.insert(EnemyCars, Car4)
  Car5 = {img=imageCar2, x=0, y=500, w=imageCar2:getWidth(), h=imageCar2:getHeight(), speed = -100, initialx = 1000, endx = 2000}
  table.insert(EnemyCars, Car5)
  Car6 = {img=imageCar3, x=0, y=600, w=imageCar3:getWidth(), h=imageCar3:getHeight(), speed = 400, initialx = 0, endx = 1000}
  table.insert(EnemyCars, Car6)
end

function love.update(dt)
  for i, car in ipairs(EnemyCars) do
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
  love.graphics.print(tonumber(Car2.x), 0, 30)

  love.graphics.draw(Kaizer.img, Kaizer.x, Kaizer.y)
  for i, car in ipairs(EnemyCars) do
    love.graphics.draw(car.img, car.x, car.y)
  end

  for i, car in ipairs(EnemyCars) do
    if collision(car.x, car.y, car.w, car.h, Kaizer.x, Kaizer.y, Kaizer.w, Kaizer.h) then
      love.graphics.print("COLLISION DETECTED", 0, 50)
    end    
  end
end

--function to detect collision between Kaizer (player) and Cars. Inputs are 
--ax = topleft x coordinate of first object A (car), ay = topleft y coordinate of object A, 
--aw = width of object A, ah = height of object A, 
--bx = topleft x coordinate of first object B (Kaizer), by = topleft y coordinate of object B, 
--bw = width of object B, bh = height of object B, 
function collision (ax, ay, aw, ah, bx, by, bw, bh)
  return ay < by + bh and
  ay + ah > by and
  ax + aw > bx and
  ax < bx + bw
end