include("asset://manager.lua")

elapsedTime = 0
inputInterval = 120
time = 0

function setup()
	manager = Manager.new()
	manager.Setup()

	local pForm = UI_Form(nil,
		7000,
		0, 0,
		"asset://view.json"
	)
	
	UI_TouchPad("touchPadCallback")

	TASK_StageOnly(pForm)
end

function update(deltaTime)
	if manager.isTimeOver() == true then
		return
	end

	manager.Update(deltaTime)
	elapsedTime = elapsedTime + deltaTime
	time = time + deltaTime

	if manager.isTimeOver() == true then
		manager.Destroy()
    	TASK_StageClear()

	   	UI_Label( nil, 7000, 400, 300, 0xFF, 0xFF0000, "AlexBrush", 32, "Game Over!")
    	UI_Label( nil, 7000, 400, 400, 0xFF, 0x000000, "AlexBrush", 32, "Time:"..math.floor(time/1000)..' seconds')
	end
end

function leave()
end

function execute(deltaT)
	update(deltaT)
end

function touchPadCallback(events)
	for idx, item in ipairs(events) do
		if item.type == PAD_ITEM_TAP then
			local activeItem = manager.getActiveItem()
			if activeItem ~= nil then
				activeItem.goRotation()
				manager.CheckIsCollided()
			end
		end
	end
end

function onUp()
	if elapsedTime > inputInterval then
		elapsedTime = 0
	end
end

function onDown()
	if elapsedTime > inputInterval then
		local activeItem = manager.getActiveItem()
		if activeItem ~= nil then
			activeItem.goDown()
			manager.CheckIsCollided()
		end

		elapsedTime = 0
	end
end

function onLeft()
	if elapsedTime > inputInterval then
		syslog("onleft")
		local activeItem = manager.getActiveItem()
		if activeItem ~= nil then
			activeItem.goLeft()
			manager.CheckIsCollided()
		end

		elapsedTime = 0
	end
end

function onRight()
	if elapsedTime > inputInterval then
		local activeItem = manager.getActiveItem()
		if activeItem ~= nil then
			activeItem.goRight()
			manager.CheckIsCollided()
		end

		elapsedTime = 0
	end
end