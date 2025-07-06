has_xcompat = minetest.get_modpath("xcompat") ~= nil
has_mcl_core = minetest.get_modpath("mcl_core") ~= nil
has_default = minetest.get_modpath("default") ~= nil
-- color configuration
local color_assignment = {
    a = "blue",
    b = "red",
    c = "green",
    d = "yellow"
}
local wool_name
if has_mcl_core then
    wool_name = "mcl_wool:"
else
    wool_name = "wool:"
end

-- LOCAL FUNCTIONS
--
local function is_colorfacedir_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "colorfacedir"
end

local function is_facedir_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "facedir" or def.paramtype2 == "colorfacedir"
end
local function is_color4dir_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "color4dir"
end
local function is_4dir_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "4dir" or def.paramtype2 == "color4dir"
end
local function is_colorwallmounted_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "colorwallmounted"
end
local function is_wallmounted_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "wallmounted" or def.paramtype2 == "colorwallmounted"
end
local function is_colordegrotate_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "colordegrotate"
end
local function is_degrotate_node(pos)
    local node = minetest.get_node_or_nil(pos)
    if not node then return false end
    local def = minetest.registered_nodes[node.name]
    return def and def.paramtype2 == "degrotate" or def.paramtype2 == "colordegrotate"
end
--
-- FUNCTION REGISTRATION
-- 
function repainter_register_repainter(rtype,rrtype,num1,num2,funk)
minetest.register_tool("repainter:repainter_"..rtype, {
    description = "Repainter "..rrtype,
    inventory_image = "repainter_repainter_"..rtype..".png",

    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.under
        if not funk or not funk(pos) then return itemstack end

        local node = minetest.get_node(pos)
        node.param2 = (node.param2 + num1) % 256
        minetest.swap_node(pos, node)

        return itemstack
    end,

    on_place = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.under
        if not funk or not funk(pos) then return itemstack end

        local node = minetest.get_node(pos)
        node.param2 = (node.param2 + num2) % 256
        minetest.swap_node(pos, node)

        return itemstack
    end,
})
if has_xcompat then
    minetest.register_craft({
        output = "repainter:repainter_"..rtype,
        recipe = {
            { wool_name..color_assignment[rtype] },
            { xcompat.materials["steel_ingot"] },
            { xcompat.materials["stick"] }
        }
    })
elseif has_mcl_core then
    minetest.register_craft({
        output = "repainter:repainter_"..rtype,
        recipe = {
            { "mcl_wool:"..color_assignment[rtype] },
            { "mcl_core:iron_ingot" },
            { "group:stick" }
        }
    })
else
    -- default
    minetest.register_craft({
        output = "repainter:repainter_"..rtype,
        recipe = {
            { "wool:"..color_assignment[rtype] },
            { "default:steel_ingot" },
            { "default:stick" }
        }
    })
end
end

function repainter_register_rotator(rtype,rrtype,num1,num2,funk)
minetest.register_tool("repainter:rotator_"..rtype, {
    description = "Rotator "..rrtype,
    inventory_image = "repainter_rotator_"..rtype..".png",

    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.under
        if not funk or not funk(pos) then return itemstack end

        local node = minetest.get_node(pos)
        node.param2 = (node.param2 + 1) % num1 + math.floor(node.param2 / num1) * num1
        minetest.swap_node(pos, node)

        return itemstack
    end,

    on_place = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.under
        if not funk or not funk(pos) then return itemstack end

        local node = minetest.get_node(pos)
        node.param2 = (node.param2 + num2) % num1 + math.floor(node.param2 / num1) * num1
        minetest.swap_node(pos, node)

        return itemstack
    end,
})
if has_xcompat then
    minetest.register_craft({
        output = "repainter:rotator_"..rtype,
        recipe = {
            { xcompat.materials["steel_ingot"] },
            { wool_name..color_assignment[rtype] },
            { xcompat.materials["steel_ingot"] }
        }
    })
elseif has_mcl_core then
    minetest.register_craft({
        output = "repainter:rotator_"..rtype,
        recipe = {
            { "mcl_core:iron_ingot" },
            { "mcl_wool:"..color_assignment[rtype] },
            { "mcl_core:iron_ingot" }
        }
    })
else
    -- default
    minetest.register_craft({
        output = "repainter:rotator_"..rtype,
        recipe = {
            { "default:steel_ingot" },
            { "wool:"..color_assignment[rtype] },
            { "default:steel_ingot" }
        }
    })
end
end

--
-- TOOL FUNCTION
-- 
--rotator_register_repainter(rtype,rrtype,num1,num2,funk)
repainter_register_repainter("a","A - (color)facedir",32,128,is_colorfacedir_node)
repainter_register_repainter("b","B - (color)4dir",4,32,is_color4dir_node)
repainter_register_repainter("c","C - (color)wallmounted",8,64,is_colorwallmounted_node)
repainter_register_repainter("d","D - (color)degrotate",32,128,is_colordegrotate_node)

--rotator_register_rotator(rtype,rrtype,num1,num2,funk)
repainter_register_rotator("a","A - facedir",32,4,is_facedir_node)
repainter_register_rotator("b","B - 4dir",4,1,is_4dir_node)
repainter_register_rotator("c","C - wallmounted",8,1,is_wallmounted_node)
repainter_register_rotator("d","D - degrotate",32,8,is_degrotate_node)

