local string_utils = {}

--
-- Returns true if `self` starts with `piece`
-- @param {string} self
-- @param {string} piece
-- @returns {boolean} true if `self` starts with `piece`
--
function string_utils:startsWith(piece)
    return string.sub(self, 1, piece:len()) == piece
end

--
-- Returns true if `self` ends with `piece`
-- @param {string} self
-- @param {string} piece
-- @returns {boolean} true if `self` ends with `piece`
--
function string_utils:endsWith(piece)
    return self:sub(-piece:len()) == piece
end

--
-- Count occurences of `pattern` in `self`
-- @param {string} self
-- @param {string} pattern
-- @returns {number} number of `pattern` occurences in `self`
--
function string_utils:countOccurences(pattern)
    local count = 0

    for _ in self:gmatch(pattern) do
        count = count + 1
    end

    return count
end

--
-- Splits `self` by `delim`
-- @param {string} self
-- @param {string} delim
-- @returns {table} Splitted elements
--
function string_utils:split(delim)
    if not self:find(delim) then
        return { self }
    end

    local result = {}
    if delim == "" or not delim then
        for i = 1, #self do
            result[i] = self:sub(i, i)
        end

        return result
    end

    local pattern = "(.-)" .. delim .. "()"
    local count = 0
    local lastPos
    for part, pos in self:gmatch(pattern) do
        count = count + 1
        result[count] = part
        lastPos = pos
    end

    result[count + 1] = self:sub(lastPos)

    return result
end

--
-- Returns number of rows and columns necessary to contains `self`
-- @param {string} self
-- @returns {number, number} Rows and columns
--
function string_utils:dimensions()
    local rows = self:split("\n")
    local columns = 0

    for _, row in ipairs(rows) do
        columns = row:len() > columns and row:len() or columns
    end

    return columns, #rows
end

return string_utils
