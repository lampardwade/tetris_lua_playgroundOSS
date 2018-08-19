include("asset://grid.lua")
include("asset://define.lua")
include("asset://item.lua")

Manager = {}

Manager.new = function()
	local this = {}
	this.isEnd = false
	this.itemList = {}

	this.Setup = function()
		syslog('----- Setup() -----')
		existTimeInterval = 400
		descentTimeInterval = 400
		backgroundPosition = Vector2.new(0, 0)
		zoneGrids = {}
		minHeightZoneGrid = 20
		mapConditionFlags = {}
		existTime = 0
		descentTime = 0
		isNextItemActive = true
		nextItemType = 0

		backgroundPosition = Vector2.new(200, 0)

		mapConditionFlags = {}
		for i=1 , 200 do
			mapConditionFlags[i] = false
		end
		nextItemType = ItemType.Item01112112
		activeItem = nil
	end

	this.Update = function(deltaTime)
		if isNextItemActive == true then
			existTime = existTime + deltaTime
			activeItem = nil

			if existTime > existTimeInterval then
				isNextItemActive = false
				existTime = 0
				activeItem = Item.new(nextItemType, InitialRotation, InitialPosition)
				activeItem.setPosition(Vector2.new(0, 0))
				table.insert(this.itemList, activeItem)

				if this.IsStartCollided() == true then
					return
				end
				nextItemType = math.random(ItemType.Item01112112, ItemType.Item11211222)
			end
		end
		if activeItem ~= nil then
			descentTime = descentTime + deltaTime
			if descentTime > descentTimeInterval then
				descentTime = 0
				activeItem.goDown()
				this.CheckIsCollided()
			end
		end
	end

	this.Destroy = function()
		for i, v in ipairs(this.itemList) do
			if v ~= nil then
				v.Destroy()
			end
		end
		this.itemList = nil
	end

	this.getActiveItem = function()
		return activeItem
	end

    this.IsGridCollided = function(position)
        if position.y < 0 then
            return true;
        elseif position.x < 0 or position.x >= 10 or position.y >= 20 or position.y < 0 then
            return true;
    	end

        local index = position.y * 10 + position.x;
        if mapConditionFlags[index + 1] ~= nil then
            return mapConditionFlags[index + 1];
        else
            return true;
        end
    end

	this.IsStartCollided = function()
		local isCollided = false
		for i=1, 4 do
			if this.IsGridCollided(activeItem.getGridPosition(i, true)) == true then
				isCollided = true
				break
			end
		end
		if isCollided == true then
--			activeItem.Destroy()
			this.isEnd = true
		end
		return isCollided
	end

	this.CheckIsCollided = function()
		local isCollided = false
		for i=1, 4 do
			if this.IsGridCollided(activeItem.getGridPosition(i, true)) == true then
				isCollided = true
				break
			end
		end

		if isCollided == true then
			if activeItem.isTargetVertical() == true then
				syslog('next item')
				isNextItemActive = true
				for i=1, 4 do
					local position = activeItem.getGridPosition(i, false)
					mapConditionFlags[position.y * 10 + position.x + 1] = true
				end
			end
		else
			activeItem.runIntoTarget()
		end

		activeItem.resetTarget()
	end

	this.isTimeOver = function()
		return this.isEnd
	end

	return this
end