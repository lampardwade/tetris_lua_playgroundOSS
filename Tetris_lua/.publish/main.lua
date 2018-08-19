include("asset://manager.lua")

function setup()
	manager = Manager.new()
	manager.Setup()

	local pForm = UI_Form(nil,	-- arg[1]:	親となるUIタスクのポインタ
		7000,		-- arg[2]:	基準表示プライオリティ
		0, 0,		-- arg[3,4]:	表示位置
		"asset://view.json"	-- arg[5]:	composit jsonのパス
	)
	--[[
		arg[6]:排他フラグ は、省略可能です。
		省略した場合は false と同じ挙動になります。
	]]
	
	TASK_StageOnly(pForm)
	syslog('----- setup() -----')
end

function update(deltaTime)
	syslog('----- onUpdate() -----')
	manager.Update(deltaTime)
end

function leave()
end

function execute(deltaT)
	syslog('----- execute() -----')
	update(deltaT)
end

function onUp()
	syslog('----- onUp() -----')
end

function onDown()
	syslog('----- onDown() -----')
end

function onLeft()
	syslog('----- onLeft() -----')
end

function onRight()
	syslog('----- onRight() -----')
end