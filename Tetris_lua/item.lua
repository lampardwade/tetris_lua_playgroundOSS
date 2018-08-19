include("asset://vector2.lua")
include("asset://grid.lua")

Item = {}

Item.new = function(type, initalRotation, initalPosition)
	local this = {}

	this.setPosition = function(position)
		for i=1, 4 do
			this.grids[i].setParentPosition(position)
		end
	end

	this.getGridPosition = function(index, isTarget)
		if isTarget == true then
			local pos = {}
			for i=1, 4 do
				pos[i] = TypeLayoutTable[this.itemType][this.targetRotation][i]
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

	this.update = function()
		this.setRotation(this.rotation)
		this.setPosition(this.position);
		for i=1, 4 do
			this.grids[i].update()
		end
	end

	this.Destroy = function()
		TASK_kill(this.obj)
		this.obj = nil
	end

	this.runIntoTarget = function()
		this.position = this.targetPosition
		this.rotation = this.targetRotation
		this.update()
	end

	this.resetTarget = function()
		this.targetPosition = this.position
		this.targetRotation = this.rotation
	end

    this.isTargetVertical = function()
    	syslog('y compare '..this.targetPosition.y..' '..this.position.y)
        return this.targetPosition.y ~= this.position.y
    end

	this.goDown = function()
		this.targetPosition = Vector2.new(this.targetPosition.x, this.targetPosition.y + 1)
	end

	this.goLeft = function()
		this.targetPosition = Vector2.new(this.targetPosition.x - 1, this.targetPosition.y)
    	syslog('go left '..this.targetPosition.x..' '..this.position.x)
	end

	this.goRight = function()
		this.targetPosition = Vector2.new(this.targetPosition.x + 1, this.targetPosition.y)
	end

	this.goRotation = function()
        if this.targetRotation + 1 == RotationType.Max then
            this.targetRotation = RotationType.Rotation_45
        else
            this.targetRotation = this.targetRotation + 1
        end
	end

	this.grids = {}
	this.itemType = type
	this.rotation = initalRotation
	this.targetRotation = initalRotation
	this.targetPosition = initalPosition
	this.position = initalPosition

	for i=1, 4 do
		this.grids[i] = Grid.new()
		syslog('grid '..i..' new')
	end
	this.update()

	return this
end