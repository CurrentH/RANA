--  This file is used by the agents,
--  when they needs to set their parameters

function setParameters( table )
    --  Go in and look at how many variables that needs to be used.

    if numVar == 1 then
        return singleParam( table )
    elseif numVar == 2 then
        return doubleParam( table )
    elseif numVar > 2 then
        return dynamicParam( table )
    else
        print("There are no variables to set")
    end
end

function singleParam( tbl )
    return tbl.stepSize * math.fmod( tbl.currentIteration, tbl.numIterations )
end

function doubleParam( tbl )
    return{
    tbl.stepSizeV1 * math.floor( tbl.currentIteration / tbl.numIterationsV1 ),
    tbl.stepSizeV2 * math.fmod( tbl.currentIteration, tbl.numIterationsV2 )
    }
end

function dynamicParam( tbl )

end

