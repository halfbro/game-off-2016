local tilespritesheet = love.graphics.newImage("assets/BaseTiles.png")

local redunitquad = love.graphics.newQuad(64*0,0,64,64, tilespritesheet:getDimensions())
local orangeunitquad = love.graphics.newQuad(64*1,0,64,64, tilespritesheet:getDimensions())
local yellowunitquad = love.graphics.newQuad(64*2,0,64,64, tilespritesheet:getDimensions())
local lightgreenunitquad = love.graphics.newQuad(64*3,0,64,64, tilespritesheet:getDimensions())
local greenunitquad = love.graphics.newQuad(64*4,0,64,64, tilespritesheet:getDimensions())
local blueunitquad = love.graphics.newQuad(64*5,0,64,64, tilespritesheet:getDimensions())
local lightblueunitquad = love.graphics.newQuad(64*6,0,64,64, tilespritesheet:getDimensions())
local purpleunitquad = love.graphics.newQuad(64*7,0,64,64, tilespritesheet:getDimensions())
local pinkunitquad = love.graphics.newQuad(64*8,0,64,64, tilespritesheet:getDimensions())
local whiteunitquad = love.graphics.newQuad(64*9,0,64,64, tilespritesheet:getDimensions())
local lightgrayunitquad = love.graphics.newQuad(64*10,0,64,64, tilespritesheet:getDimensions())
local grayunitquad = love.graphics.newQuad(64*11,0,64,64, tilespritesheet:getDimensions())

local redhconn = love.graphics.newQuad(64*0+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local orangehconn = love.graphics.newQuad(64*1+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local yellowhconn = love.graphics.newQuad(64*2+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local lightgreenhconn = love.graphics.newQuad(64*3+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local greenhconn = love.graphics.newQuad(64*4+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local bluehconn = love.graphics.newQuad(64*5+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local lightbluehconn = love.graphics.newQuad(64*6+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local purplehconn = love.graphics.newQuad(64*7+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local pinkhconn = love.graphics.newQuad(64*8+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local whitehconn = love.graphics.newQuad(64*9+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local lightgrayhconn = love.graphics.newQuad(64*10+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())
local grayhconn = love.graphics.newQuad(64*11+8, 64*1+20, 12, 20, tilespritesheet:getDimensions())

local redvconn = love.graphics.newQuad(64*0+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local orangevconn = love.graphics.newQuad(64*1+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local yellowvconn = love.graphics.newQuad(64*2+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local lightgreenvconn = love.graphics.newQuad(64*3+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local greenvconn = love.graphics.newQuad(64*4+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local bluevconn = love.graphics.newQuad(64*5+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local lightbluevconn = love.graphics.newQuad(64*6+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local purplevconn = love.graphics.newQuad(64*7+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local pinkvconn = love.graphics.newQuad(64*8+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local whitevconn = love.graphics.newQuad(64*9+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local lightgrayvconn = love.graphics.newQuad(64*10+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())
local grayvconn = love.graphics.newQuad(64*11+36, 64*1+24, 20, 12, tilespritesheet:getDimensions())

local spriteayy = love.graphics.newQuad(64*0, 64*2, 64, 64, tilespritesheet:getDimensions())

local attackreticle = love.graphics.newQuad(64*0, 64*7, 64,64, tilespritesheet:getDimensions())
local movereticle = love.graphics.newQuad(64*1, 64*7, 64,64, tilespritesheet:getDimensions())
local selector = love.graphics.newQuad(64*6, 64*7, 64, 64, tilespritesheet:getDimensions())

local finishedindicator = love.graphics.newQuad(64*2, 64*7, 64,64, tilespritesheet:getDimensions())

local entrypoint = love.graphics.newQuad(64*7, 64*7, 64, 64, tilespritesheet:getDimensions())

local groundnormalquad = love.graphics.newQuad(64*8,64*7,64,64, tilespritesheet:getDimensions())
local grounddecor1quad = love.graphics.newQuad(64*9,64*7,64,64, tilespritesheet:getDimensions())
local grounddecor2quad = love.graphics.newQuad(64*10,64*7,64,64, tilespritesheet:getDimensions())
local grounddecor3quad = love.graphics.newQuad(64*11,64*7,64,64, tilespritesheet:getDimensions())

return {
  tilespritesheet = tilespritesheet,

  redtile = {tile=redunitquad, hconn=redhconn, vconn=redvconn},
  orangetile = {tile=orangeunitquad, hconn=orangehconn, vconn=orangevconn},
  yellowtile = {tile=yellowunitquad, hconn=yellowhconn, vconn=yellowvconn},
  lightgreentile = {tile=lightgreenunitquad, hconn=lightgreenhconn, vconn=lightgreenvconn},
  greentile = {tile=greenunitquad, hconn=greenhconn, vconn=greenvconn},
  bluetile = {tile=blueunitquad, hconn=bluehconn, vconn=bluevconn},
  lightbluetile = {tile=lightblueunitquad, hconn=lightbluehconn, vconn=lightbluevconn},
  purpletile = {tile=purpleunitquad, hconn=purplehconn, vconn=purplevconn},
  pinktile = {tile=pinkunitquad, hconn=pinkhconn, vconn=pinkvconn},
  whitetile = {tile=whiteunitquad, hconn=whitehconn, vconn=whitevconn},
  lightgraytile = {tile=lightgrayunitquad, hconn=lightgrayhconn, vconn=lightgrayvconn},
  graytile = {tile=grayunitquad, hconn=grayhconn, vconn=grayvconn},

  ayy = spriteayy,

  attackreticle = attackreticle,
  movereticle = movereticle,
  selector = selector,

  finishedindicator = finishedindicator,

  entrypoint = entrypoint,

  groundnormal = groundnormalquad,
  grounddecor1 = grounddecor1quad,
  grounddecor2 = grounddecor2quad,
  grounddecor3 = grounddecor3quad,
}
