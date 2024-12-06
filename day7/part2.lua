function splitStr(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function map(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

function subrange(t, first, last)
    return table.move(t, first, last, 1, {})
end

io.input("input.txt")
local inFile = io.read("*all")
local lines = splitStr(inFile, "\n");
for i, value in ipairs(lines) do
    print(i, value);
end
local eqls = map(lines,
    function(v)
        return splitStr(v, ": ")
    end)
local total = 0
print()
for k, value in pairs(eqls) do
    local target = tonumber(value[1])
    local opts = map(subrange(value,3,#value), tonumber)
    local sVal = tonumber(value[2])
    print("at", k,"/",#eqls)
    local possibilities = tonumber(3^(#opts) - 1)
    for i=0,possibilities do
        local val = sVal
        for j=1,#opts do
            local op = (i // 3^(j - 1)) % 3
            if op == 0 then
                val = val * opts[j]
            elseif op == 1 then
                val = val + opts[j]
            else
                val = tonumber(tostring(val) .. tostring(opts[j]))
            end
        end
        if val == target then
            total = total + target
            break
        end
    end
end

--[[
* +
* *
* |
+ +
+ *
+ |
| +
| *
| |

]]

print(total)