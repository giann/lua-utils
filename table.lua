local table_utils = {}

--
-- Returns a table of `t` keys
-- @param {table} t
-- @returns {table} List of `t` keys
--
function table_utils.keys(t)
    local keys = {}
    for k, _ in pairs(t) do
        table.insert(keys, k)
    end
    return keys
end

--
-- Changes the contents of a table by removing or replacing existing elements and/or adding new elements.
-- Basically the same semantics as JS Array.prototype.splice(). The hash part of the table is left untouched.
-- @param {table} t
-- @param {number} start Index at which to start changing the table (with origin 1). If greater than the length of the
-- table, actual starting index will be set to the length of the table. If negative, will begin that many elements
-- from the end of the table (with origin -1) and will be set to 1 if absolute value is greater than the length of
-- the table.
-- @param {number|nil} deleteCount An integer indicating the number of old table elements to remove. If deleteCount
-- is omitted, or if its value is larger than #t - start (that is, if it is greater than the number
-- of elements left in the table, starting at start), then all of the elements from start through the end of the table
-- will be deleted. If deleteCount is 0 or negative, no elements are removed. In this case, you should specify at least
-- one new element.
-- @param {mixed} ... The elements to add to the table, beginning at the start index. If you don't specify any elements,
-- splice() will only remove elements from the table.
-- @returns {table} An table containing the deleted elements. If only one element is removed, an table of one element is
-- returned. If no elements are removed, an empty table is returned.
--
function table_utils.splice(t, start, deleteCount, ...)
    local removed = {}
    start = start > #t and #t or start
    start = math.max(1, start < 0 and #t - start or start)
    deleteCount = deleteCount or #t - start
    local replacements = {...}

    for i = 1, deleteCount do
        table.insert(removed, t[start + i - 1])

        if i <= #replacements then
            t[start + i - 1] = replacements[i]
        else
            table.remove(t, start + #replacements)
        end
    end

    return removed
end

--
-- Returns a shallow copy of a portion of an table into a new table object selected from `begin` to `end` (`end`
-- included). The original table will not be modified. The hash part of the table is ignored.
-- Same semantics as JS Array.prototype.slice() except `end` is included.
-- @param {table} t
-- @param {number|nil} Index at which to begin extraction. A negative index can be used, indicating an offset
-- from the end of the sequence. If nil, slice begins from index 1. If greater than the length of the sequence,
-- an empty table is returned.
-- @param {number|nil} Index before which to end extraction. `slice` extracts up to and including `end`. A negative
-- index can be used, indicating an offset from the end of the sequence. If omitted, `slice` extracts
-- through the end of the sequence. If greater than the length of the sequence, slice extracts through
-- to the end of the sequence.
-- @returns {table} Extracted elements.
--
function table_utils.slice(t, i1, i2)
    local res = {}
    local n = #t

    -- default values for range
    i1 = i1 or 1
    i1 = math.max(1, i1 < 0 and n - i1 or i1)

    if i1 > n then
        return {}
    end

    i2 = i2 and i2 or n
    i2 = math.min(
        n,
        math.max(1, i2 < 0 and n - i2 or i2)
    )

    local k = 1
    for i = i1, i2 do
        res[k] = t[i]
        k = k + 1
    end

    return res
end


--
-- Returns a new table with the content of `t1` and `t2` array part. The hash part of `t1` and `t2` is ignored.
-- @param {table} t1
-- @param {table} t2
-- @returns {table} New table with content of `t1` and `t2`
--
function table_utils.join(t1, t2)
    local res = {}

    for i = 1, #t1 do
        table.insert(res, t1[i])
    end

    for i = 1, #t2 do
        table.insert(res, t2[i])
    end

    return res
end

--
-- Returns a shallow merge of `t1` and `t2`
-- @param {table} t1
-- @param {table} t2
-- @returns {table} Shallow merge of `t1` and `t2`
--
function table_utils.merge(t1, t2)
    local t = {}

    for k, v in pairs(t1) do
        t[k] = v
    end

    for k, v in pairs(t2) do
        t[k] = v
    end

    return t
end

--
-- Recursive merge of `t1` and `t2`
-- @param {table} t1
-- @param {table} t2
-- @returns {table} Recursive merge of `t1` and `t2`
--
function table_utils.rmerge(t1, t2, seen)
    seen = seen or {}
    local merged = {}

    for k, v in pairs(t1) do
        merged[k] = v
    end

    for k, v in pairs(t2) do
        if type(v) == "table" and not seen[v] then
            seen[v] = true

            if type(merged[k]) ~= "table" then
                merged[k] = {}
            end

            merged[k] = table_utils.rmerge(merged[k], v, seen)
        else
            merged[k] = v
        end
    end

    return merged
end

--
-- Returns keys at which `element` is in table `t`
-- @param {table} t
-- @param {mixed} element
-- @returns Key of `element` in `t`
--
function table_utils.indexOf(t, element)
    for k, v in pairs(t) do
        if v == element then
            return k
        end
    end
    return nil
end

--
-- Removes any occurence of `element` in table `t`
-- @param {table} t
-- @param {mixed} element
--
function table_utils.removeOccurence(t, element)
    for k, v in pairs(t) do
        if v == element then
            if type(k) == "number" then
                table.remove(t, k)
            else
                t[k] = nil
            end
        end
    end
end

--
-- Returns a new table filtered by `filterFn`
-- @param {table} t
-- @param {function} filterFn Takes key and value of the current element. If returns `false`, element is filtered out
-- @returns {table} Filtered version of `t`
--
function table_utils.filter(t, filterFn)
    local filtered = {}

    for k, v in pairs(t) do
        if filterFn(k, v) then
            filtered[k] = v
        end
    end

    return filtered
end

--
-- Same as `filter` but ignores the hash part of `t`
-- @param {table} t
-- @param {function} filterFn Takes key and value of the current element. If returns `false`, element is filtered out
-- @returns {table} Filtered version of `t`
--
function table_utils.ifilter(t, filterFn)
    local filtered = {}

    for k, v in ipairs(t) do
        if filterFn(k, v) then
            table.insert(filtered, v)
        end
    end

    return filtered
end

--
-- Returns a new table with elements of `t` transformed by `mapFn`
-- @param {table} t
-- @param {function} mapFn Takes key and value of the current element. It's return value is added to the result table
-- @returns {table} Mapped table
--
function table_utils.map(t, mapFn)
    local mapped = {}

    for k, v in pairs(t) do
        table.insert(mapped, mapFn(k, v))
    end

    return mapped
end

--
-- Reduce content of `t` to an accumulated value starting at `initial`
-- @param {table} t
-- @param {mixed} initial Initial value
-- @param {function} Takes the current reduced value and the current element's key and value
-- @returns {mixed} The reduced value
--
function table_utils.reduce(t, initial, reduceFn)
    for k, v in pairs(t) do
        initial = reduceFn(initial, k, v)
    end

    return initial
end

--
-- Return the sum of all number elements of `t`
-- @param {table} t
-- @returns Sum of elements of `t`
--
function table_utils.sum(t)
    local sum = 0
    for _, v in pairs(t) do
        sum = sum + (type(v) == "number" and v or 0)
    end

    return sum
end

--
-- Runs `fn` for each element of `t`
-- @param {table} t
-- @param {function} fn Takes key and value of the current element
--
function table_utils.forEach(t, fn)
    for k, v in pairs(t) do
        fn(k, v)
    end
end

--
-- Returns `true` if `t` is a sequence of number-indexed elements
-- @param {table} t
-- @returns {boolean} `true` if `t` is an array
--
function table_utils.isArray(t)
    local numKeys = 0
    for _, _ in pairs(t) do
        numKeys = numKeys+1
    end
    local numIndices = 0
    for _, _ in ipairs(t) do
        numIndices = numIndices+1
    end
    return numKeys == numIndices
end

--
-- Returns number of elements in `t`. Unlike #, will account for the hash part of `t`.
-- @param {table} t
-- @returns Number of elements in `t`
--
function table_utils.tlength(t)
    local count = 0

    for _ in pairs(t) do
        count = count + 1
    end

    return count
end

--
-- Returns true if `t1` contains all elements (key,value couples) of `t2`
-- @param {table} t1
-- @param {table} t2
-- @param {table|nil} ignore List of keys to ignore
-- @returns {boolean} True if `t1` contains `t2`
--
function table_utils.isSubset(t1, t2, ignore, seen)
    seen = seen or {}
    ignore = ignore or {}

    seen[t1] = true
    seen[t2] = true

    for k, v in pairs(t1) do
        if type(v) == "table"
            and type(t2[k]) == "table"
            and t2[k] ~= v
            and not seen[v] then
            return table_utils.isSubset(v, t2[k], ignore, seen)
        end

        if not table_utils.contains(ignore, k) and t2[k] ~= v then
            return false
        end
    end
    return true
end

--
-- Shuffle `t` in-place
-- @param {table} t
-- @param {function|nil} rand Random function. If ommited, math.random is used.
--
function table_utils.shuffle(t, rand)
    rand = rand or math.random
    local iterations = #t
    local j

    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

return table_utils
