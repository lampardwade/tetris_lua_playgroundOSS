include("asset://vector2.lua")
include("asset://define.lua")
include("asset://grid.lua")

Item = {}

Item.new = function(type)
	local this = {}

	this.grids = {}
	this.defaultPosition = Vector2.new(3, -1)
	this.rotation = RotationType.Rotation_45
	this.targetRotation = RotationType.Rotation_45
	this.itemType = type
	syslog('getGridPosition')
	this.targetPosition = Vector2.new(0, 0)
	this.position = Vector2.new(0, 0)

	for i=1, 4 do
		this.grids[i] = Grid.new()
	end

	this.setPosition = function(position)
		for i=1, 4 do
			this.grids[i].setParentaPosition(position)
		end
	end

	this.getGridPosition = function(index, isTarget)
		if isTarget == true then
			local pos = {}
			for i=1, 4 do
				syslog('getGridPosition')
				pos[i] = TypeLayoutTable[this.itemType][this.targetRotation][i]
				syslog(pos[i].x)
				syslog(pos[i].y)
			end

			return Vector2.new(this.targetPosition.x + pos[index].x,
				this.targetPosition.y + pos[index].y)
		else
			return this.grids[index].WorldPosition()
		end
	end

	this.setRotation = function(rotationType)
		for i=1, 4 do
			this.grids[i].setPosition(TypeLayoutTable[this.itemType][rotationType][i])
		end
	end

	this.setTargetRotation = function()
		
	end

	this.goDown = function()
		this.targetPosition.y = this.targetPosition.y + 1
	end

	this.goLeft = function()
		this.targetPosition.x = this.targetPosition.x - 1
	end

	this.goRight = function()
		this.targetPosition.x = this.targetPosition.x + 1
	end

	return this
end