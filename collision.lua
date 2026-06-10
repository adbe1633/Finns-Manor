function cmap(o, sp)
    local ct=false
    local cb=false
  
    -- if colliding with map tiles
    if(o.cm) then
      local x1=o.x/8
      local y1=o.y/8 
      local x2=(o.x+7)/8
      local y2=(o.y+7)/8 
      local a=fget(mget(x1,y1),sp)
      local b=fget(mget(x1,y2),sp)
      local c=fget(mget(x2,y2),sp)
      local d=fget(mget(x2,y1),sp)
      ct=a or b or c or d
     end
     -- if colliding world bounds
     if(o.cw) then
       cb=(o.x<0 or o.x+8>w or
             o.y<0 or o.y+8>h)
     end
  
    return ct or cb
  end