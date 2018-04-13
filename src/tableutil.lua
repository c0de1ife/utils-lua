---
--- table tools for Lua.
--- Created by c0de1ife.
--- DateTime: 2018/4/13 19:02
---

local tbfunc = {}

-- dump a table(if not a table, print it directly)
-- tb is the table to dump, sp is separator, level is recursion times.
-- tb is required. sp and level are optional.
function tbfunc.dump(tb, sp, level)
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
                tbfunc.dump(v, (sp) .. "\t")
            elseif level > 1 then
                print(sp, k .. " = ")
                tbfunc.dump(v, (sp) .. "\t", level - 1)
            else
                print(sp, k .. " = " .. tostring(v))
            end
        end
    end
    print(sp .. "}")
end

-- parse Patterns
-- escape magic characters
local function pp(str)
    return str:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", function(c)
        return "%" .. c
    end)
end

-- Turn a string(with one separator) into a table
-- sp is separator, mpt as true will keep empty string.
-- call 'tbfunc.str2tb1("1;2;3;;5",";")' can get '["1","2","3","5"]'
function tbfunc.str2tb1(str, sp, mpt)
    sp = sp or ","
    pp(sp)
    if mpt then
        sp = "[^" .. sp .. "]*"
    else
        sp = "[^" .. sp .. "]+"
    end
    local tb = {}
    for v in string.gmatch(str, sp) do
        tb[#tb + 1] = v
    end
    return tb
end

-- Turn a string(with two separator) into a table
-- sp1 and sp2 are separators, mpt as true will keep empty string as value(key is not allowed to be empty).
-- call 'tbfunc.str2tb2("a=b%c=d%e=","=","%",true)' can get '{"a":"b","c":"d","e":""}'
function tbfunc.str2tb2(str, sp1, sp2, mpt)
    sp1 = sp1 or "="
    sp1 = pp(sp1)
    sp2 = sp2 or "&"
    sp2 = pp(sp2)
    if mpt then
        sp1 = "([^" .. sp2 .. "]+)" .. sp1 .. "([^" .. sp2 .. "]*)"
    else
        sp1 = "([^" .. sp2 .. "]+)" .. sp1 .. "([^" .. sp2 .. "]+)"
    end
    local tb = {}
    for k, v in string.gmatch(str, sp1) do
        tb[k] = v
    end
    return tb
end

return tbfunc
