---
--- url tools for Lua.
--- Created by c0de1ife.
--- DateTime: 2018/4/13 18:04
---

local url = {}

--url encoding (percent-encoding)
function url.encode(url)
    return (url:gsub("[^a-zA-Z0-9%-_%.~!%*'%(%);:@&=%+%$,/%?#%[%]]", function (c)
        return string.format('%%%X', string.byte(c))
    end))
end

--url decoding (percent-encoding)
function url.decode(url)
    return (url:gsub("%%(..)", function (c)
        return string.char(tonumber(c, 16))
    end))
end

return url
