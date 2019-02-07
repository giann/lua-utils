local math_utils = {}

--
-- Rotate a point around (0,0)
-- @param {number} x Point to rotate x
-- @param {number} y Point to rotate y
-- @param {number} angle
-- @returns {number, number} Rotated point
--
function math_utils.rotateO(x, y, angle)
    local x3 = x * math.cos(angle) - y * math.sin(angle)
    local y3 = x * math.sin(angle) + y * math.cos(angle)

    return x3, y3
end

--
-- Rotate a point around another
-- @param {number} x Point to rotate x
-- @param {number} y Point to rotate y
-- @param {number} ox Origin point x
-- @param {number} oy Origin point y
-- @param {number} angle
-- @returns {number, number} Rotated point
--
function math_utils.rotate(x, y, ox, oy, angle)
    local x1 = x - ox
    local y1 = y - oy

    local x2 = x1 * math.cos(angle) - y1 * math.sin(angle)
    local y2 = x1 * math.sin(angle) + y1 * math.cos(angle)

    return x2 + ox, y2 + oy
end

--
-- Return distance between two points
-- @param {number} x
-- @param {number} y
-- @param {number} x2
-- @param {number} y2
-- @returns {number} Distance between (x,y) and (x2,y2)
--
function math_utils.distance(x, y, x2, y2)
    return math.sqrt(math.pow(x2 - x, 2) + math.pow(y2 - y, 2))
end

return math_utils
