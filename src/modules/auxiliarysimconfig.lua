require = textutils

filename = "_simconfig.data"
simulationIterations = 5

function _loadNumberIterations()
    print("\t\t\t\tLUA - Aux sim - Inside loadNumberIterations")

    if simulationIterations == nil then
        return 1
    end

    print( textutils.serialize( agent_1 ) )

    return simulationIterations
end

function test()

    file = io.open(filename, "w+")
    io.output(file)
    io.write(agent_1.name)
    io.close(file)

end

function writeToSimconfig( it )
end

simAgents ={
agent_1,
agent_2
}


agent_1 = {
name="agent1",
from=1,
to=100
}

agent_2 = {
name="agent2",
from=1,
to=10
}
