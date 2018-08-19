include("asset://vector2.lua")
include("asset://define.lua")

Grid = {}

Grid.new = function()
	local this = {}
	this.gridHeight = 64
	this.gridWidth = 64
	local gridName = "asset://assets/item.png.imag"
	this.obj = UI_SimpleItem(nil, 7000, 400, 600, gridName)
	this.position = Vector2.new(0, 0)
	this.parentPosition = Vector2.new(0, 0)

	this.setPosition = function(position)
		this.position.x = position.x
		this.position.y = position.y
	end

	this.setParentPosition = function(position)
		this.parentPosition.x = position.x
		this.parentPosition.y = position.y
	end

	this.WorldPosition = function()
		return Vector2.new(this.position.x + this.parentPosition.x,
			this.position.y + this.parentPosition.y)
	end

	-- TODO 未実装
	this.setColor = function(color)
		this.color = color
	end

	this.Down = function(times)
		this.position.y = this.position.y + times
		this.Update()
	end

	this.update = function()
	  	local prop = TASK_getProperty(this.obj)
  		prop.color = this.color
	    prop.x = this.WorldPosition().x * SquareSize
	    prop.y = this.WorldPosition().y * SquareSize

	    TASK_setProperty(this.obj, prop) 
	end

	return this
end