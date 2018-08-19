include("asset://grid.lua")
include("asset://define.lua")
include("asset://item.lua")

Manager = {}

Manager.new = function()
	local this = {}

	this.Setup = function()
		syslog('----- Setup() -----')
		existTimeInterval = 1
		descentTimeInterval = 1
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
		descentTimeInterval = 1
		activeItem = nil
		syslog('----- Setup() success-----')
	end

	this.Update = function(deltaTime)
		syslog('----- Update() -----')
		if isNextItemActive == true then
			existTime = existTime + deltaTime
			activeItem = nil
			syslog('----- Update() -----1')

			if existTime > existTimeInterval then
				syslog('----- Update() -----2')
				isNextItemActive = false
				existTime = 0
				activeItem = Item.new(nextItemType)

				if this.IsStartCollided() == true then
					return
				end
				nextItemType = math.random(ItemType.Item01112112, ItemType.Item11211222)
			end
		end
		if activeItem ~= nil then
			syslog('----- Update() -----3')
			descentTime = descentTime + deltaTime
			if descentTime > descentTimeInterval then
				descentTime = 0
				activeItem.goDown()
				this.CheckIsCollided()
			end
		end
	end

    this.IsGridCollided = function(position)
        if position.y < 0 then
            return true;
        elseif position.x < 0 or position.x >= 10 or position.y >= 20 or position.y < 0 then
            return true;
    	end

        local index = position.y * 10 + position.x;
        if #mapConditionFlags > index then
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
			activeItem.Destroy()
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



		end
	end

	return this
end