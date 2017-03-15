filename = "_simconfig.data"
simulationIterations = 3

simAgents = {
{name="agent1",v1_f=0,v2_f=0,v1_t=5,v2_t=10},
{name="agent2",from=1,to=10}
}

function _loadNumberIterations()
    print("\t\t\t\tLUA - Aux sim - Inside loadNumberIterations")

    if simulationIterations == nil then
        return 1
    end

    print(simAgents[1].name)

    saveTable(simAgents,filename)

    return simulationIterations
end

function saveTable( tbl,filename )
    local charS,charE = "   ","\n"
    local file,err = io.open( filename, "wb" )

    if err then
        return err
    end

    -- initiate variables for save procedure
    local tables,lookup = { tbl },{ [tbl] = 1 }
    file:write( "return {"..charE )

    for idx,t in ipairs( tables ) do
        file:write( "-- Table: {"..idx.."}"..charE )
        file:write( "{"..charE )
        local thandled = {}

        for i,v in ipairs( t ) do
            thandled[i] = true
            local stype = type( v )
            if stype == "table" then
                if not lookup[v] then
                    table.insert( tables, v )
                    lookup[v] = #tables
                end
                file:write( charS.."{"..lookup[v].."},"..charE )
            elseif stype == "string" then
                file:write(  charS..exportstring( v )..","..charE )
            elseif stype == "number" then
                file:write(  charS..tostring( v )..","..charE )
            end
        end

        for i,v in pairs( t ) do
            -- escape handled values
            if (not thandled[i]) then
                local str = ""
                local stype = type( i )
                -- handle index
                if stype == "table" then
                    if not lookup[i] then
                        table.insert( tables,i )
                        lookup[i] = #tables
                    end
                    str = charS.."[{"..lookup[i].."}]="
                elseif stype == "string" then
                    str = charS.."["..exportstring( i ).."]="
                elseif stype == "number" then
                    str = charS.."["..tostring( i ).."]="
                end

                if str ~= "" then
                    stype = type( v )
                    -- handle value
                    if stype == "table" then
                        if not lookup[v] then
                            table.insert( tables,v )
                            lookup[v] = #tables
                        end
                        file:write( str.."{"..lookup[v].."},"..charE )
                    elseif stype == "string" then
                        file:write( str..exportstring( v )..","..charE )
                    elseif stype == "number" then
                        file:write( str..tostring( v )..","..charE )
                    end
                end
            end
        end
        file:write( "},"..charE )
    end
    file:write( "}" )
    file:close()
end

function exportstring( s )
    return string.format("%q", s)
end







