---
--- table tools for Lua.
--- Created by c0de1ife.
--- DateTime: 2018/4/13 19:02
---


-- dump a table(if not a table, print it directly)
-- tb is the table to dump, sp is separator, level is recursion times.
-- tb is required. sp and level are optional.
function dump(tb, sp, level)
    if type(tb) ~= "table" then
        print(tb)
        return
    end
    sp = sp or ""
    print(sp .. "{")
    for k, v in pairs(tb or {}) do
        local tp = type(v)
        if tp ~= "table" then
            if tp == "string" then
                print(sp, k .. ' = "' .. v .. '"')
            elseif tp == "boolean" then
                print(sp, k .. " = '" .. tostring(v) .. "'")
            elseif tp == "number" then
                print(sp, k .. " = " .. v)
            elseif tp == "function" then
                print(sp, k .. " = " .. tostring(v))
            end
        else
            if not level then
                print(sp, k .. " = ")
                print_table(v, (sp) .. "\t")
            elseif level > 1 then
                print(sp, k .. " = ")
                print_table(v, (sp) .. "\t", level - 1)
            else
                print(sp, k .. " = " .. tostring(v))
            end
        end
    end
    print(sp .. "}")
end
