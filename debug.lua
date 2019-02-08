local debug_utils = {}

--
-- Prints out the content of `t` in a human readable form
-- @param {table} t
--
function debug_utils.dump(e, inc, seen)
    if type(e) == "table" then
        inc = inc or 1
        seen = seen or {}

        seen[e] = true
        local s = "{\n"

        for k, v in pairs(e) do
            s = s .. ("     "):rep(inc) .. "["

            local typeK = type(k)
            local typeV = type(v)

            if typeK == "table" and not seen[v] then
                s = s .. debug_utils.dump(k, inc + 1)
            elseif typeK == "string" then
                s = s .. "\"" .. k .. "\""
            else
                s = s .. tostring(k)
            end

            s = s .. "]: "

            if typeV == "table" and not seen[v] then
                s = s .. debug_utils.dump(v, inc + 1) .. ",\n"
            elseif typeV == "string" then
                s = s .. "\"" .. v .. "\",\n"
            else
                s = s .. tostring(v) .. ",\n"
            end
        end

        s = s .. ("\t"):rep(inc - 1).. "}"

        return s
    elseif type(e) == "string" then
        return string.format("%q", e)
    end

    return tostring(e)
end

return debug_utils
