local has_xcompat = minetest.get_modpath("xcompat") ~= nil
local has_mcl_core = minetest.get_modpath("mcl_core") ~= nil
local has_default = minetest.get_modpath("default") ~= nil

local color_assignment = {
    a = "blue",
    b = "red",
    c = "green",
    d = "yellow"
}

local wool_name = has_mcl_core and "mcl_wool:" or "wool:"

for _, def in ipairs(repainter_tool_defs or {}) do
    local name = "repainter:" .. def.tooltype .. "_" .. def.rtype
    local wool = wool_name .. color_assignment[def.color]

    local recipe
    if has_xcompat then
        if def.tooltype == "repainter" then
            recipe = {
                { wool },
                { xcompat.materials["steel_ingot"] },
                { xcompat.materials["stick"] }
            }
        else
            recipe = {
                { xcompat.materials["steel_ingot"] },
                { wool },
                { xcompat.materials["steel_ingot"] }
            }
        end
    elseif has_mcl_core then
        if def.tooltype == "repainter" then
            recipe = {
                { wool },
                { "mcl_core:iron_ingot" },
                { "group:stick" }
            }
        else
            recipe = {
                { "mcl_core:iron_ingot" },
                { wool },
                { "mcl_core:iron_ingot" }
            }
        end
    else
        if def.tooltype == "repainter" then
            recipe = {
                { wool },
                { "default:steel_ingot" },
                { "default:stick" }
            }
        else
            recipe = {
                { "default:steel_ingot" },
                { wool },
                { "default:steel_ingot" }
            }
        end
    end

    minetest.register_craft({
        output = name,
        recipe = recipe
    })
end
