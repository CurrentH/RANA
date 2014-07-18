
-- Init of the lua frog, function called upon initilization of the LUA auton:
function initAuton(x, y, id, macroFactor, timeResolution)

	posX = x
	posY = y
	ID = id
	macroF = macroFactor
	timeRes = timeResolution

	l_debug("Agent #: " .. id .. " has been initialized")
    
	l_modifyMap(10,10,255,0,0)

end

-- Event Handling:
function handleInternalEvent(origX, origY, origID, origDesc, origTable)
	--make a response:

	return 0,0,0,"null"
end	

--Determine whether or not this Auton will initiate an event.
function initiateEvent()

		newPosX = l_getMersenneInteger(0,200)
		newPosY = l_getMersenneInteger(0,200)
		
		l_modifyMap(newPosX, newPosY,0,0,250)
		r,g,b = l_checkMap(newPosX, newPosY)
		--l_debug("color "..r..","..g..","..b)
		calltable = {name = "communication", index = 2, arg1 = callStrength}
		s_calltable = serializeTbl(calltable) 
		desc = "sound"
		id = l_generateEventID()
		propagationSpeed = 50000
		
		targetID = 0;
		
		l_gridMove(posX, posY, newPosX, newPosY)
		posX = newPosX
		posY = newPosY

		int

		return propagationSpeed, s_calltable, desc, targetID
		
end


function getSyncData()
	return posX, posY
end

function simDone()
	l_debug("Agent #: " .. ID .. " is done\n")
end

function processFunction(posX, posY, callTable)
	--load the callTable:
	loadstring("ctable="..callTable)()
	--handle the call:
	if ctable.name == "" then
		if ctable.index == 1 then
			return func.execute()
		elseif ctable.index == 2 then
			return func.execute()
		end
	end
end
