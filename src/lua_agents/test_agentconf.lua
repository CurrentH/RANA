-- Import Rana lua libraries.

function InitializeAgent()
    local agent1 = require("test_agent_osc")
    agent1.printVar()
    agent1.incrementValue()
    agent1.printVar()

    local agent2 = require("test_agent_osc")
    agent2.printVar()
    agent2.incrementValue()
    agent2.printVar()
end

function takeStep()
    --  Do nothing until the simulation is done
end

function cleanUp()
    --  Remove all the agents
end

function simulationIterationDone()
    --  Increment numIteration, and run the simulation again
end

