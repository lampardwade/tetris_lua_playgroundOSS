include("asset://vector2.lua")

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
		Update()
	end
	this.setParentPosition = function(position)
		this.parentPosition.x = position.x
		this.parentPosition.y = position.y
		Update()
	end
	this.WorldPosition = function()
		return Vector2.new(this.position.x + this.parentPosition.x,
			this.position.y + this.parentPosition.y)
	end
	this.setColor = function(color)
		this.color = color
		Update()
	end
	this.Down = function(times)
		this.position.y = this.position.y + times
		Update()
	end
	this.Update = function()
	  	local prop = TASK_getProperty(this.obj)
  		prop.color = this.color
	    prop.x = this.WorldPosition.x
	    prop.y = this.WorldPosition.y
	    TASK_setProperty(this.obj, prop) 
	end

	return this
end