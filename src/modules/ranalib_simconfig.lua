----begin_license--
--
--Copyright 	2013 - 2016 	Søren Vissing Jørgensen.
--                     2017     Theis Strøm-Hansen
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

--  This is used as a middle link between the agents, and the simulation
--  we want to be able to run the same simulation multiple times automatically.
--  We also want to be able to run the simulation multiple times, where the agents
--  change parameters between each iteration.
--

--  The following global values are set via the [INSERT]:
-- ------------------------------------
-- VARIABLES.
-- ------------------------------------
-- n         --  Number of iterations the simulation should do.
-- ------------------------------------

--  1:  Start simulation with i-j
--  2:  Initialize agents wiht i-j
--  3:  When simulation is done
--  4:  Do this is for loops for however many variables needed.

i = 1
n = 10

function _startSimulation()
    local a = 1
    local b = 1
    local c = a + b
end

function _stopSimulation()
end

function _restartSimulation()
end

function _pauseSimulation()
end

function _continiueSimulation()
end
