

local easing = require "easing"

--just for readability
local tween_types = {
	Linear=1,

	Quadratic_In=2,
	Quadratic_Out=3,
	Quadratic_InOut=4,

	Cubic_In=5,
	Cubic_Out=6,
	Cubic_InOut=7,

	Quartic_In=8,
	Quartic_Out=9,
	Quartic_InOut=10,

	Quintic_In=11,
	Quintic_Out=12,
	Quintic_InOut=13,

	Sine_In=14,
	Sine_Out=15,
	Sine_InOut=16,

	Circular_In=17,
	Circular_Out=18,
	Circular_InOut=19,

	Elastic_In=20,
	Elastic_Out=21,
	Elastic_InOut=22,

	Bounce_In=23,
	Bounce_Out=24,
	Bounce_InOut=25,

	Back_In=26,
	Back_Out=27,
	Back_InOut=28,
}

local wrap_modes = {
	Once = 1,
	Loop = 2,
	PingPong = 3,
}
-----------------------------------------------------------------------------------

local mt = {}
mt.__index = mt
function mt:make(tween_type, times, wrap_mode, start_val, end_val)
	self.container = self.container or {}
	self.times = times
	self.wrap_mode = wrap_mode or 1
	self.frames = easing.easing(self.container, tween_type, start_val or 0, end_val or 1, times)

	self.step_index = 0
	self.delta = 1
	self.target = self.times
end

function mt:step()
	self.step_index = self.step_index + self.delta
	local val = self.container[self.step_index]

	if self.step_index == self.target then
		if self.wrap_mode == wrap_modes.Once then
			return val, false
		elseif self.wrap_mode == wrap_modes.Loop then
			self.step_index = 1 - self.delta
			return val, false
		elseif self.wrap_mode == wrap_modes.PingPong then
			self.delta = -self.delta
			self.target = self.target == 1 and self.times or 1
			return val, false
		end
	end
	return val, true
end

function mt:test()
	if self.wrap_mode == wrap_modes.Once then
		while true do
			local val, alive = self:step()
			print(val)
			if not alive then
				print("done")
				break
			end
			os.execute("sleep 0.2")
		end
	end
	if self.wrap_mode == wrap_modes.Loop or self.wrap_mode == wrap_modes.PingPong then
		while true do
			local val, rounding = self:step()
			print(val)
			if not rounding then
				print("round end")
			end
			os.execute("sleep 0.2")
		end
	end

	self.step_index = 0
	self.delta = 1
	self.target = self.times
end


-----------------------------------------------------------------------------------
local M = {}
function M.new()
	return setmetatable({}, mt)
end

M.type = tween_types
M.wrap_mode = wrap_modes

return M


