--based on richy486's implementation
function a_star()
    --start at cat
    start = {flr(cat.x/8), flr(cat.y/8)}
    --goal at player
    goal = {flr(player.x/8), flr(player.y/8)}

    printh("start...")
    frontier = {}
    insert(frontier, start, 0)
    came_from = {}
    came_from[vectoindex(start)] = nil
    cost_so_far = {}
    cost_so_far[vectoindex(start)] = 0

    while (#frontier > 0 and #frontier < 1000) do
        current = popEnd(frontier)
        if vectoindex(current) == vectoindex(goal) then
            break
        end

        local neighbours = getNeighbours(current)
        for next in all(neighbours) do
            local nextIndex = vectoindex(next)

            local new_cost = cost_so_far[vectoindex(current)]  + 1 -- add extra costs here

            if (cost_so_far[nextIndex] == nil) or (new_cost < cost_so_far[nextIndex]) then
                cost_so_far[nextIndex] = new_cost
                local priority = new_cost + heuristic(goal, next)
                insert(frontier, next, priority)

                came_from[nextIndex] = current

                -- if (nextIndex != vectoindex(start)) and (nextIndex != vectoindex(goal)) then
                --     mset(next[1],next[2],11)
                -- end
            end 
        end
    end

    printh("find goal..")
    current = came_from[vectoindex(goal)]
    path = {}
    local cindex = vectoindex(current)
    local sindex = vectoindex(start)

    while cindex != sindex do
        add(path, current)
        current = came_from[cindex]
        cindex = vectoindex(current)
    end
    reverse(path)

    -- for point in all(path) do
    --     mset(point[1],point[2],10)
    -- end

    printh("..done")
    print(path[1], 0, 0)
    return path[1]
end


-- manhattan distance on a square grid
function heuristic(a, b)
    return abs(a[1] - b[1]) + abs(a[2] - b[2])
end
   
-- find all existing neighbours of a position that are not walls
function getNeighbours(pos)
    local neighbours={}
    local x = pos[1]
    local y = pos[2]
    if x > 0 and (fget(mget(x-1,y), wallFlagId) != true) then
        add(neighbours,{x-1,y})
    end
    if x < 15 and (fget(mget(x+1,y), wallFlagId) != true) then
        add(neighbours,{x+1,y})
    end
    if y > 0 and (fget(mget(x,y-1), wallFlagId) != true) then
        add(neighbours,{x,y-1})
    end
    if y < 15 and (fget(mget(x,y+1), wallFlagId) != true) then
        add(neighbours,{x,y+1})
    end

    -- for making diagonals
    if (x+y) % 2 == 0 then
        reverse(neighbours)
    end
    return neighbours
end



-- insert into start of table
function insert(t, val)
    for i=(#t+1),2,-1 do
        t[i] = t[i-1]
    end
    t[1] = val
end

-- insert into table and sort by priority
function insert(t, val, p)
    if #t >= 1 then
        add(t, {})
        for i=(#t),2,-1 do
        
        local next = t[i-1]
        if p < next[2] then
        t[i] = {val, p}
        return
        else
        t[i] = next
        end
        end
        t[1] = {val, p}
    else
        add(t, {val, p}) 
    end
end

-- pop the last element off a table
function popEnd(t)
    local top = t[#t]
    del(t,t[#t])
    return top[1]
end

function reverse(t)
    for i=1,(#t/2) do
        local temp = t[i]
        local oppindex = #t-(i-1)
        t[i] = t[oppindex]
        t[oppindex] = temp
    end
end

-- translate a 2d x,y coordinate to a 1d index and back again
function vectoindex(vec)
    return maptoindex(vec[1],vec[2])
end

function maptoindex(x, y)
    return ((x+1) * 16) + y
end

function indextomap(index)
    local x = (index-1)/16
    local y = index - (x*w)
    return {x,y}
end








-- find the first location of a specific tile type
function getSpecialTile(tileid)
    for x=0,15 do
        for y=0,15 do
            local tile = mget(x,y)
            if tile == tileid then
                return {x,y}
            end
        end
    end
    printh("did not find tile: "..tileid)
end