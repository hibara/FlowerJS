###
 "flower.js"

   paints 2D various kinds of flower shapes with using 'HTML5 Canvas'.
   This script don't use image files ( bmp/jpg/png and so on) at all,
   creates 2D flower shapes with line, pure color and gradation only.
   If you change various parameters or set random parameters,
   various kinds of flowers would bloom out on your browser!

 Try it demos.

 Simple Demo.
 http://hibara.org/software/flowerjs/

 Web service with flower.js
 http://hanacanvas.net/

 Copyright (C) 2013 M.Hibara, All rights reserved.
 http://hibara.org/

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 3 of the License, or (at
 your option) any later version.

 This program is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program. If not, see

 http://www.gnu.org/licenses/

###

class FlowerJS

  FlowerCanvas   : null
  drawingContext : null

  flowerCurrent  : null
  flowerPink     : null
  flowerBlue     : null
  flowerOrange   : null
  flowerYellow   : null

  constructor: ->
    @createCanvas()
    @resizeCanvas()
    @createDrawingContext()
    @initFlowers()
    @bloomFlowers(256, 256)

  createCanvas: ->
    @FlowerCanvas = document.createElement 'canvas'
    document.body.appendChild @FlowerCanvas

    #canvas click event.
    @FlowerCanvas.addEventListener 'click',(e)=>
      rect = e.target.getBoundingClientRect();
      if e.offsetX
        mouseX = e.offsetX - rect.left
        mouseY = e.offsetY - rect.top
      else if e.layerX
        mouseX = e.layerX - rect.left
        mouseY = e.layerY - rect.top
      @bloomFlowers(mouseX, mouseY)
    ,false

  ###
  Canvas size
  ###
  resizeCanvas: ->
    @FlowerCanvas.height = 512
    @FlowerCanvas.width = 512

  ###
  Create 2d Context
  ###
  createDrawingContext: ->
    @drawingContext = @FlowerCanvas.getContext '2d'

  ###
  Create flower object.
  ###
  createFlower : (ptlsNum, ptlsLen, subpos1x, subpos1y, subpos2x, subpos2y,
                  col1R, col1G, col1B, col2R, col2G, col2B, col3R, col3G, col3B) ->
    ptlsNum  : Number(ptlsNum)
    ptlsLen  : Number(ptlsLen)
    subpos1x : Number(subpos1x)
    subpos1y : Number(subpos1y)
    subpos2x : Number(subpos2x)
    subpos2y : Number(subpos2y)
    col1R    : Number(col1R)
    col1G    : Number(col1G)
    col1B    : Number(col1B)
    col2R    : Number(col2R)
    col2G    : Number(col2G)
    col2B    : Number(col2B)
    col3R    : Number(col3R)
    col3G    : Number(col3G)
    col3B    : Number(col3B)

  ###
  A random kind of Some flowers are blooming in starting.
  ###
  initFlowers :  ->
    @flowerPink    = @createFlower(8, 16, 16, -8, 4, -4, 255, 80, 80, 255, 188, 180, 255, 230, 230)
    @flowerBlue    = @createFlower(6, 32, 16, -6, -16, -10, 200, 200, 255, 0, 0, 255, 180, 180, 255)
    @flowerOrange  = @createFlower(5, 24, 0, -1, -10, -14, 255, 160, 80, 255, 220, 180, 255, 245, 230)
    @flowerYellow  = @createFlower(24, 48, 0, 8, -10, -14, 230, 230, 80, 255, 170, 55, 255, 255, 160)
    initNum = @randRange(0, 3)
    switch initNum
      when 1 then @flowerCurrent = @flowerBlue
      when 2 then @flowerCurrent = @flowerOrange
      when 3 then @flowerCurrent = @flowerYellow
      else @flowerCurrent = @flowerPink;

  ###
  Some flowers are blooming.
  ###
  bloomFlowers : (posx, posy) ->
    # add random number of flowers
    addnum = @randRange(4, 8)
    # paint a flower
    for i in [0...addnum]
      px = @randRange(posx-54, posx+54)
      py = @randRange(posy-54, posy+54)
      # one flower
      @aFlower(px, py, @flowerCurrent)
    @mutateFlower()

  ###
  Mutatie current flower.
  ###
  mutateFlower :  ->
    num = @randRange(0, 15)
    switch num
      when 0
        @flowerCurrent.ptlsNum = @normalDistribution(flowerCurrent.ptlsNum, 4)
      when 1
        @flowerCurrent.ptlsLen = @normalDistribution(flowerCurrent.ptlsLen, 4)
      when 2
        @flowerCurrent.subpos1x = @normalDistribution(flowerCurrent.subpos1x, 2)
      when 3
        @flowerCurrent.subpos1y = @normalDistribution(flowerCurrent.subpos1y, 2)
      when 4
        @flowerCurrent.subpos2x = @normalDistribution(flowerCurrent.subpos2x, 2)
      when 5
        @flowerCurrent.subpos2y = @normalDistribution(flowerCurrent.subpos2y, 2)
      when 6
        @flowerCurrent.col1R = @colorMutation(@flowerCurrent.col1R)
      when 7
        @flowerCurrent.col1G = @colorMutation(@flowerCurrent.col1G)
      when 8
        @flowerCurrent.col1B = @colorMutation(@flowerCurrent.col1B)
      when 9
        @flowerCurrent.col2R = @colorMutation(@flowerCurrent.col2R)
      when 10
        @flowerCurrent.col2G = @colorMutation(@flowerCurrent.col2G)
      when 11
        @flowerCurrent.col2B = @colorMutation(@flowerCurrent.col2B)
      when 13
        @flowerCurrent.col3R = @colorMutation(@flowerCurrent.col3R)
      when 14
        @flowerCurrent.col3G = @colorMutation(@flowerCurrent.col3G)
      when 15
        @flowerCurrent.col3B = @colorMutation(@flowerCurrent.col3B)
      else

  ###
  Mutate flower's petals color
  ###
  colorMutation : (colval) ->
    colval = @normalDistribution(colval, 30)
    if colval > 255
      colval = 255;
    else if colval < 0
      colval = 0;
    else
      colval

  ###
  A flower is open
  ###
  aFlower : (posx, posy, objFlw) ->

    # the start of the points to paint ( central points of flower )
    p0x = posx
    p0y = posy

    petalsNum = objFlw.ptlsNum

    ## the end of the points to paint
    p3x = p0x + objFlw.ptlsLen
    p3y = p0y

    # sub line ( bulges out )
    p1x = p0x + objFlw.subpos1x
    p1y = p0y + objFlw.subpos1y
    p2x = p3x + objFlw.subpos2x	# relative distance of the end points
    p2y = p3y + objFlw.subpos2y
    # sub line ( to create mirroring image )
    p4x = p3x + objFlw.subpos2x
    p4y = p3y - objFlw.subpos2y
    p5x = p0x + objFlw.subpos1x
    p5y = p0y - objFlw.subpos1y

    # flower's color
    col1 = 'rgb('+objFlw.col1R+','+objFlw.col1G+','+objFlw.col1B+')'
    col2 = 'rgb('+objFlw.col2R+','+objFlw.col2G+','+objFlw.col2B+')'
    col3 = 'rgb('+objFlw.col3R+','+objFlw.col3G+','+objFlw.col3B+')'
    # color transparent
    TransParent = 1
    # size
    Size = 1

    # border width
    @drawingContext.lineWidth = 2
    # transparent of border
    @drawingContext.globalAlpha = TransParent
    # scale
    @drawingContext.scale(Size, Size)

    n0 = 0
    n1 = 1
    angle = 0

    # calc rotation angle for number of petals
    for i in [0...petalsNum]

      if  i > Math.ceil(petalsNum/2)-1
        angle = (360/petalsNum)*n1
        n1 = n1 + 2

      else
        angle = (360/petalsNum)*n0
        n0 = n0 + 2

      radian = angle * Math.PI / 180	#rotation angle

      # start to paint
      @drawingContext.beginPath()

      # gradation color
      grad_r = @rotatePosition(radian, p0x, p0y, p3x, p3y)
      grad = @drawingContext.createLinearGradient(p0x, p0y, grad_r.x, grad_r.y)
      ###
       gradation samples
       grad.addColorStop(0,'rgb(192, 80, 77)');    // red
       grad.addColorStop(0.5,'rgb(155, 187, 89)'); // green
       grad.addColorStop(1,'rgb(128, 100, 162)');  // purple
      ###
      grad.addColorStop(0,  col1)
      grad.addColorStop(0.5, col2)
      grad.addColorStop(1,  col3)
      @drawingContext.fillStyle = grad;

      # calc rotation points
      p1_r = @rotatePosition(radian, p0x, p0y, p1x, p1y)
      p2_r = @rotatePosition(radian, p0x, p0y, p2x, p2y)
      p3_r = @rotatePosition(radian, p0x, p0y, p3x, p3y)
      p4_r = @rotatePosition(radian, p0x, p0y, p4x, p4y)
      p5_r = @rotatePosition(radian, p0x, p0y, p5x, p5y)

      @drawingContext.moveTo(p0x, p0y)
      @drawingContext.bezierCurveTo(p1_r.x, p1_r.y, p2_r.x, p2_r.y, p3_r.x, p3_r.y)
      @drawingContext.bezierCurveTo(p4_r.x, p4_r.y, p5_r.x, p5_r.y, p0x, p0y)      # close mirror image.
      @drawingContext.closePath()
      @drawingContext.stroke()                                                     # paint line
      @drawingContext.fill()                                                       # fill color

  # class aFlower end.

  ###
  Random numbers in range
  ###
  randRange: (minnum, maxnum) ->
    randVal = Math.round(Math.random()*(maxnum-minnum))+minnum
    randVal

  ###
  Calc rotation points
  ###
  rotatePosition: (radian, cx, cy, x1, y1) ->
    x: ((x1-cx) * Math.cos(-radian) - (y1-cy) * Math.sin(-radian) + cx)
    y: ((x1-cx) * Math.sin(-radian) + (y1-cy) * Math.cos(-radian) + cy)

  ###
  Get random number with Norma distribution
  ###
  normalDistribution: (value, range) ->
    a = 1 - Math.random();
    b = 1 - Math.random();
    c = Math.sqrt(-2 * Math.log(a));
    if 0.5 - Math.random() > 0
      value = Math.floor(c * Math.sin(Math.PI * 2 * b) * range + value)
    else
      value = Math.floor(c * Math.cos(Math.PI * 2 * b) * range + value)
    value


#class FlowerJS end.

window.FlowerJS = FlowerJS
