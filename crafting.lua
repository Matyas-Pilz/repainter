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
