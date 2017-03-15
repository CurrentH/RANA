----begin_license--
--
--Copyright 	2013 	Søren Vissing Jørgensen.
--			2014	Søren Vissing Jørgensen, Center for Bio-Robotics, SDU, MMMI.  
--
--This file is part of RANA.
--
--RANA is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--RANA is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with RANA.  If not, see <http://www.gnu.org/licenses/>.
--
----end_license--

-- @Description:
-- This agent will oscilate between 0 and 1, with a time period. Upon peaking it will emit an event. 
-- and then rapidly fall down towards zero and restart.
--
-- Upon receiving a signal from another oscillator it will, interrupt it's current cycle, reset
-- and after a small pause it will resume a new cycle.
--
-- Data for each period will stored it a table, which upon simulation cleanUp is written
-- to the harddrive.

-- ID -- id of the agent.
-- PositionX --	this agents x position.
-- PositionY -- this agents y position.
-- STEP_RESOLUTION 	-- resolution of steps.
-- EVENT_RESOLUTION 	-- resolution of event distribution.
-- StepMultiple 	-- step resolution multiplier (default = 1).

-- data sets
Olevels = {}
dataFactor = 100
step = 0
iteration = 1

-- Oscillator values:
T = 0.500 -- time period.
e = 0.030 -- period variance with mean of 0.
r = 0.100 -- falltime.
Tt = 0 -- active period targeted time.
Tn = 0 -- active period time
y = 0.05 -- interrupt pause
s = .2 -- Prc(phase response) slope, how quickly the oscillator recover from inhibition (the smaller the faster).
t = 0.060
x = 0.050
yy = 0

pause = false
reset = false
peaked = false

-- Import Rana lua libraries.
Event	= require "ranalib_event"
Core	= require "ranalib_core"
Stat	= require "ranalib_statistic"
Agent 	= require "ranalib_agent"

-- Init of the lua frog, function called upon initilization of the LUA auton.
function initializeAgent()
        l_debug("Oscillator agent #: " .. ID .. " is being initialized")

        tbl = loadParameters("agent1")

        --setParameters(tbl)

    print("\n\n\n")


    local currentIT = 155

    local minV1 = tbl.v1_f
    local maxV1 = tbl.v1_t
    local stepV1 = 0.1
    local itV1 = (maxV1 - minV1)/stepV1

    local minV2 = tbl.v2_f
    local maxV2 = tbl.v2_t
    local stepV2 = 0.1
    local itV2 = (maxV2 - minV2)/stepV2

    print(minV1, maxV1, stepV1, itV1)
    print(minV2, maxV2, stepV2, itV2)

    local V1 = stepV1 * math.floor( currentIT / itV1 )
    local V2 = stepV2 * math.fmod( currentIT, itV2)


    print("Iteration: ", currentIT)
    print("The current variables are: V1: ", V1, " V2: ", V2)

    print("\n\n\n")



        --positionX = Stat.randomMean(ENV_WIDTH/4,ENV_WIDTH/2)
        --positionY = Stat.randomMean(ENV_HEIGHT/4,ENV_HEIGHT/2)
        --say("GFie "..ID.." x "..positionX.." y "..positionY)

        Tt = T + Stat.randomMean(e,0)
end

function takeStep()

	Tn = Tn + STEP_RESOLUTION

	if pause == true and Tn >= yy then
		table.insert(Olevels, Core.time()..",".. 0)
		pause = false	
	end

	if peaked == false and Tn >= Tt-t then
		table.insert(Olevels, Core.time()..",".. 1 ..",peak")
		peaked = true
	end

	if reset==false and Tn >= r then
		table.insert(Olevels,Core.time()..",".. 0)
		reset = true
	end

	if Tn >= Tt then
		--say("PRC Oscillator "..ID.." Emitting signal at time: ".. Core.time().."[s]")
		Event.emit{description="Signal"}
		table.insert(Olevels, Core.time()..",".. (Tn-r)/(Tt) ..",call")
		Tt = T + Stat.randomMean(e, 0)
		Tn = 0
		peaked = false
		reset = false
	end
end

function handleEvent(sourceX, sourceY, sourceID, eventDescription, eventTable)
	
	if Tn >= x then
		-- write data to the Olevel table:
		table.insert(Olevels, Core.time()..","..Tn/Tt..",interrupt")
		table.insert(Olevels, Core.time()..",".. 0)
		--calculate new period
		Tt = Tn * s + Tt
		yy = y+Tn
		if peaked == true then
			Tn = Tt-y
		end
		pause = true
	end
end

function cleanUp()
        l_debug("Agent "..ID.." is doing clean up - Green")

	--Write the oscillation data to a csv file.
	if ID <= 4 then
                file = io.open("test_output/green_data"..ID..".csv", "w")
		for i,v in pairs(Olevels) do
			file:write(i..","..v.."\n")
		end
		file:close()
	end

        Agent.removeAgent(ID)
        l_debug("Agent " .. ID .. " is done")
end

function setParameter( tbl )
    --  Min: 0  Max: 10
    --  Min: 0  Max: 10
    --  Stepsize 1. (Total iterations 100)

    --var1 = (Stepsize * iteration) mod maxVar1
    --var2 = (Stepsize * iteration) division maxVar2

end


--  TODO: Put function somewhere else so all agents can get to it
function loadParameters( key )

    local ftables,err = loadfile( "_simconfig.data" )
    if err then
        return _,err
    end

    local tables = ftables()

    for idx = 1,#tables do

        local tolinki = {}

        for i,v in pairs( tables[idx] ) do
            --if i == "iteration" then
            --    currentIteration =
            --end
            if i == "name" and v == key then

                if type( v ) == "table" then
                    tables[idx][i] = tables[v[1]]
                end

                if type( i ) == "table" and tables[i[1]] then
                    table.insert( tolinki,{ i,tables[i[1]] } )
                end

            end

        end

        for _,v in ipairs( tolinki ) do
            tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
        end

    end

    for i = 1,#tables do
        if tables[i].name == key then
            return tables[i]
        end
    end

    return nil

end

