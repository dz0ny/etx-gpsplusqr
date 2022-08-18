
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["app"] = function(...) 
-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

-- End of Lua Library inline imports
local ____exports = {}
local plusmap = {
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "C",
    "F",
    "G",
    "H",
    "J",
    "M",
    "P",
    "Q",
    "R",
    "V",
    "W",
    "X"
}
____exports.App = __TS__Class()
local App = ____exports.App
App.name = "App"
function App.prototype.____constructor(self, w, h)
    self.w = 0
    self.h = 0
    self.latitude = 0
    self.longitude = 0
    self.gps = nil
    self.showqr = false
    self.w = w
    self.h = h
    self.latitude = 0
    self.longitude = 0
    if getFieldInfo(nil, "GPS") ~= nil then
        self.gps = getFieldInfo(nil, "GPS").id
    end
end
function App.prototype.getcode(self, lat, lon)
    local int = math.floor(lat)
    local codepair = plusmap[int + 1]
    lat = 20 * (lat - int)
    int = math.floor(lon)
    codepair = codepair .. plusmap[int + 1]
    lon = 20 * (lon - int)
    return {lat, lon, codepair}
end
function App.prototype.pluscode(self)
    local latc = (self.latitude + 90) / 20
    local lonc = (self.longitude + 180) / 20
    local pluscode = ""
    do
        local index = 1
        while index <= 4 do
            local latl, lonl, _ = table.unpack(self:getcode(latc, lonc))
            latc = latl
            lonc = lonl
            index = index + 1
        end
    end
    pluscode = pluscode .. "+"
    local latp, lonp, codepair = table.unpack(self:getcode(latc, lonc))
    latc = latp
    lonc = lonp
    pluscode = pluscode .. codepair
    pluscode = pluscode .. plusmap[4 * math.floor(latc / 5) + math.floor(lonc / 4) + 1]
    return pluscode
end
function App.prototype.draw(self)
    local mid = self.w / 2
    lcd:clear()
    if self.showqr then
        local url = (("https://www.google.com/maps/search/?api=1&query=" .. tostring(self.latitude)) .. "%2C") .. tostring(self.longitude)
        local qr1 = qrcodegen.QrCode:encodeText(url, qrcodegen.QrCode.Ecc.MEDIUM)
        do
            local y = 0
            while y < qr1.size do
                do
                    local x = 0
                    while x < qr1.size do
                        if qr1:getModule(x, y) then
                            lcd:drawPoint(mid + x, y)
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
    else
        lcd:drawText(mid - 53, 5, "GPS coordinates are")
        lcd:drawText(
            mid - 44,
            15,
            (tostring(self.latitude) .. " , ") .. tostring(self.longitude)
        )
        lcd:drawText(mid - 49, 35, "Google Plus Code is")
        lcd:drawText(
            mid - 32,
            45,
            self:pluscode()
        )
    end
end
function App.prototype.keyHandler(self, event)
    repeat
        local ____switch14 = event
        local ____cond14 = ____switch14 == EVT_VIRTUAL_NEXT or ____switch14 == EVT_VIRTUAL_PREV
        if ____cond14 then
            local ____ = self.showqr ~= self.showqr
            break
        end
    until true
end
function App.prototype.bg(self)
    if self.gps ~= nil then
        self.latitude = self.gps.lat
        self.longitude = self.gps.lon
    end
    return 0
end
function App.prototype.run(self, event, touchState)
    self:draw()
    self:keyHandler(event)
    return 0
end
return ____exports
 end,
["qr"] = function(...) 
-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

-- End of Lua Library inline imports
local ____exports = {}
local ____app = require("app")
local App = ____app.App
local app
local function init(self, w, h)
    if w == nil then
        w = LCD_W
    end
    if h == nil then
        h = LCD_H
    end
    app = __TS__New(App, w, h)
end
local function run(self, event, touchState)
    return app:run(event, touchState)
end
local function bg(self)
    return app:bg()
end
____exports.init = init
____exports.run = run
____exports.bg = bg
return ____exports
 end,
["qrgen"] = function(...) 
-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        return debug.traceback(nil, level)
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            if _VERSION == "Lua 5.1" or caller and caller.func ~= error then
                return description
            else
                return (tostring(description) .. "\n") .. self.stack
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_2 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        local ____temp_1
        if self.message ~= "" then
            ____temp_1 = (self.name .. ": ") .. self.message
        else
            ____temp_1 = self.name
        end
        return ____temp_1
    end
    Error = ____initErrorClass_2(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_4 = initErrorClass
        local ____class_3 = __TS__Class()
        ____class_3.name = ____class_3.name
        __TS__ClassExtends(____class_3, Error)
        function ____class_3.prototype.____constructor(self, ...)
            ____class_3.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_4(nil, ____class_3, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    local ____first_0 = first
    if ____first_0 == nil then
        ____first_0 = 0
    end
    first = ____first_0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    local ____last_1 = last
    if ____last_1 == nil then
        ____last_1 = len
    end
    last = ____last_1
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if select("#", ...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = select("#", ...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        local ____deleteCount_0 = deleteCount
        if ____deleteCount_0 == nil then
            ____deleteCount_0 = 0
        end
        actualDeleteCount = ____deleteCount_0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if length ~= length or length <= 0 then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = string.match(numberString, "^%s*-?0[xX]")
            if hexMatch then
                base = 16
                local ____string_match_result__0_0
                if string.match(hexMatch, "-") then
                    ____string_match_result__0_0 = "-" .. __TS__StringSubstr(numberString, #hexMatch)
                else
                    ____string_match_result__0_0 = __TS__StringSubstr(numberString, #hexMatch)
                end
                numberString = ____string_match_result__0_0
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local ____temp_1
        if base <= 10 then
            ____temp_1 = __TS__StringSubstring(parseIntBasePattern, 0, base)
        else
            ____temp_1 = __TS__StringSubstr(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        end
        local allowedDigits = ____temp_1
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber(
            string.match(numberString, pattern),
            base
        )
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    local ____string_byte_result_0 = string.byte(self, index + 1)
    if ____string_byte_result_0 == nil then
        ____string_byte_result_0 = 0 / 0
    end
    return ____string_byte_result_0
end

-- End of Lua Library inline imports
local ____ = "use strict"
qrcodegen = qrcodegen or ({})
do
    local appendBits, getBit, ____assert
    function appendBits(self, val, len, bb)
        if len < 0 or len > 31 or bit32.rshift(val, len) ~= 0 then
            error(
                __TS__New(RangeError, "Value out of range"),
                0
            )
        end
        do
            local i = len - 1
            while i >= 0 do
                bb[#bb + 1] = bit32.band(
                    bit32.rshift(val, i),
                    1
                )
                i = i - 1
            end
        end
    end
    function getBit(self, x, i)
        return bit32.band(
            bit32.rshift(x, i),
            1
        ) ~= 0
    end
    function ____assert(self, cond)
        if not cond then
            error(
                __TS__New(Error, "Assertion error"),
                0
            )
        end
    end
    qrcodegen.QrCode = __TS__Class()
    local QrCode = qrcodegen.QrCode
    QrCode.name = "QrCode"
    function QrCode.prototype.____constructor(self, version, errorCorrectionLevel, dataCodewords, msk)
        self.version = version
        self.errorCorrectionLevel = errorCorrectionLevel
        self.modules = {}
        self.isFunction = {}
        if version < qrcodegen.QrCode.MIN_VERSION or version > qrcodegen.QrCode.MAX_VERSION then
            error(
                __TS__New(RangeError, "Version value out of range"),
                0
            )
        end
        if msk < -1 or msk > 7 then
            error(
                __TS__New(RangeError, "Mask value out of range"),
                0
            )
        end
        self.size = version * 4 + 17
        local row = {}
        do
            local i = 0
            while i < self.size do
                row[#row + 1] = false
                i = i + 1
            end
        end
        do
            local i = 0
            while i < self.size do
                local ____self_modules_0 = self.modules
                ____self_modules_0[#____self_modules_0 + 1] = __TS__ArraySlice(row)
                local ____self_isFunction_1 = self.isFunction
                ____self_isFunction_1[#____self_isFunction_1 + 1] = __TS__ArraySlice(row)
                i = i + 1
            end
        end
        self:drawFunctionPatterns()
        local allCodewords = self:addEccAndInterleave(dataCodewords)
        self:drawCodewords(allCodewords)
        if msk == -1 then
            local minPenalty = 1000000000
            do
                local i = 0
                while i < 8 do
                    self:applyMask(i)
                    self:drawFormatBits(i)
                    local penalty = self:getPenaltyScore()
                    if penalty < minPenalty then
                        msk = i
                        minPenalty = penalty
                    end
                    self:applyMask(i)
                    i = i + 1
                end
            end
        end
        ____assert(nil, 0 <= msk and msk <= 7)
        self.mask = msk
        self:applyMask(msk)
        self:drawFormatBits(msk)
        self.isFunction = {}
    end
    function QrCode.encodeText(self, text, ecl)
        local segs = qrcodegen.QrSegment:makeSegments(text)
        return qrcodegen.QrCode:encodeSegments(segs, ecl)
    end
    function QrCode.encodeBinary(self, data, ecl)
        local seg = qrcodegen.QrSegment:makeBytes(data)
        return qrcodegen.QrCode:encodeSegments({seg}, ecl)
    end
    function QrCode.encodeSegments(self, segs, ecl, minVersion, maxVersion, mask, boostEcl)
        if minVersion == nil then
            minVersion = 1
        end
        if maxVersion == nil then
            maxVersion = 40
        end
        if mask == nil then
            mask = -1
        end
        if boostEcl == nil then
            boostEcl = true
        end
        if not (qrcodegen.QrCode.MIN_VERSION <= minVersion and minVersion <= maxVersion and maxVersion <= qrcodegen.QrCode.MAX_VERSION) or mask < -1 or mask > 7 then
            error(
                __TS__New(RangeError, "Invalid value"),
                0
            )
        end
        local version
        local dataUsedBits
        do
            version = minVersion
            while true do
                local dataCapacityBits = qrcodegen.QrCode:getNumDataCodewords(version, ecl) * 8
                local usedBits = qrcodegen.QrSegment:getTotalBits(segs, version)
                if usedBits <= dataCapacityBits then
                    dataUsedBits = usedBits
                    break
                end
                if version >= maxVersion then
                    error(
                        __TS__New(RangeError, "Data too long"),
                        0
                    )
                end
                version = version + 1
            end
        end
        for ____, newEcl in ipairs({qrcodegen.QrCode.Ecc.MEDIUM, qrcodegen.QrCode.Ecc.QUARTILE, qrcodegen.QrCode.Ecc.HIGH}) do
            if boostEcl and dataUsedBits <= qrcodegen.QrCode:getNumDataCodewords(version, newEcl) * 8 then
                ecl = newEcl
            end
        end
        local bb = {}
        for ____, seg in ipairs(segs) do
            appendBits(nil, seg.mode.modeBits, 4, bb)
            appendBits(
                nil,
                seg.numChars,
                seg.mode:numCharCountBits(version),
                bb
            )
            for ____, b in ipairs(seg:getData()) do
                bb[#bb + 1] = b
            end
        end
        ____assert(nil, #bb == dataUsedBits)
        local dataCapacityBits = qrcodegen.QrCode:getNumDataCodewords(version, ecl) * 8
        ____assert(nil, #bb <= dataCapacityBits)
        appendBits(
            nil,
            0,
            math.min(4, dataCapacityBits - #bb),
            bb
        )
        appendBits(nil, 0, (8 - #bb % 8) % 8, bb)
        ____assert(nil, #bb % 8 == 0)
        do
            local padByte = 236
            while #bb < dataCapacityBits do
                appendBits(nil, padByte, 8, bb)
                padByte = bit32.bxor(
                    padByte,
                    bit32.bxor(236, 17)
                )
            end
        end
        local dataCodewords = {}
        while #dataCodewords * 8 < #bb do
            dataCodewords[#dataCodewords + 1] = 0
        end
        __TS__ArrayForEach(
            bb,
            function(____, b, i)
                local ____dataCodewords_2, ____temp_3 = dataCodewords, bit32.rshift(i, 3) + 1
                local ____dataCodewords_index_4 = bit32.bor(
                    ____dataCodewords_2[____temp_3],
                    bit32.lshift(
                        b,
                        7 - bit32.band(i, 7)
                    )
                )
                ____dataCodewords_2[____temp_3] = ____dataCodewords_index_4
                return ____dataCodewords_index_4
            end
        )
        return __TS__New(
            qrcodegen.QrCode,
            version,
            ecl,
            dataCodewords,
            mask
        )
    end
    function QrCode.prototype.getModule(self, x, y)
        return 0 <= x and x < self.size and 0 <= y and y < self.size and self.modules[y + 1][x + 1]
    end
    function QrCode.prototype.drawFunctionPatterns(self)
        do
            local i = 0
            while i < self.size do
                self:setFunctionModule(6, i, i % 2 == 0)
                self:setFunctionModule(i, 6, i % 2 == 0)
                i = i + 1
            end
        end
        self:drawFinderPattern(3, 3)
        self:drawFinderPattern(self.size - 4, 3)
        self:drawFinderPattern(3, self.size - 4)
        local alignPatPos = self:getAlignmentPatternPositions()
        local numAlign = #alignPatPos
        do
            local i = 0
            while i < numAlign do
                do
                    local j = 0
                    while j < numAlign do
                        if not (i == 0 and j == 0 or i == 0 and j == numAlign - 1 or i == numAlign - 1 and j == 0) then
                            self:drawAlignmentPattern(alignPatPos[i + 1], alignPatPos[j + 1])
                        end
                        j = j + 1
                    end
                end
                i = i + 1
            end
        end
        self:drawFormatBits(0)
        self:drawVersion()
    end
    function QrCode.prototype.drawFormatBits(self, mask)
        local data = bit32.bor(
            bit32.lshift(self.errorCorrectionLevel.formatBits, 3),
            mask
        )
        local rem = data
        do
            local i = 0
            while i < 10 do
                rem = bit32.bxor(
                    bit32.lshift(rem, 1),
                    bit32.rshift(rem, 9) * 1335
                )
                i = i + 1
            end
        end
        local bits = bit32.bxor(
            bit32.bor(
                bit32.lshift(data, 10),
                rem
            ),
            21522
        )
        ____assert(
            nil,
            bit32.rshift(bits, 15) == 0
        )
        do
            local i = 0
            while i <= 5 do
                self:setFunctionModule(
                    8,
                    i,
                    getBit(nil, bits, i)
                )
                i = i + 1
            end
        end
        self:setFunctionModule(
            8,
            7,
            getBit(nil, bits, 6)
        )
        self:setFunctionModule(
            8,
            8,
            getBit(nil, bits, 7)
        )
        self:setFunctionModule(
            7,
            8,
            getBit(nil, bits, 8)
        )
        do
            local i = 9
            while i < 15 do
                self:setFunctionModule(
                    14 - i,
                    8,
                    getBit(nil, bits, i)
                )
                i = i + 1
            end
        end
        do
            local i = 0
            while i < 8 do
                self:setFunctionModule(
                    self.size - 1 - i,
                    8,
                    getBit(nil, bits, i)
                )
                i = i + 1
            end
        end
        do
            local i = 8
            while i < 15 do
                self:setFunctionModule(
                    8,
                    self.size - 15 + i,
                    getBit(nil, bits, i)
                )
                i = i + 1
            end
        end
        self:setFunctionModule(8, self.size - 8, true)
    end
    function QrCode.prototype.drawVersion(self)
        if self.version < 7 then
            return
        end
        local rem = self.version
        do
            local i = 0
            while i < 12 do
                rem = bit32.bxor(
                    bit32.lshift(rem, 1),
                    bit32.rshift(rem, 11) * 7973
                )
                i = i + 1
            end
        end
        local bits = bit32.bor(
            bit32.lshift(self.version, 12),
            rem
        )
        ____assert(
            nil,
            bit32.rshift(bits, 18) == 0
        )
        do
            local i = 0
            while i < 18 do
                local color = getBit(nil, bits, i)
                local a = self.size - 11 + i % 3
                local b = math.floor(i / 3)
                self:setFunctionModule(a, b, color)
                self:setFunctionModule(b, a, color)
                i = i + 1
            end
        end
    end
    function QrCode.prototype.drawFinderPattern(self, x, y)
        do
            local dy = -4
            while dy <= 4 do
                do
                    local dx = -4
                    while dx <= 4 do
                        local dist = math.max(
                            math.abs(dx),
                            math.abs(dy)
                        )
                        local xx = x + dx
                        local yy = y + dy
                        if 0 <= xx and xx < self.size and 0 <= yy and yy < self.size then
                            self:setFunctionModule(xx, yy, dist ~= 2 and dist ~= 4)
                        end
                        dx = dx + 1
                    end
                end
                dy = dy + 1
            end
        end
    end
    function QrCode.prototype.drawAlignmentPattern(self, x, y)
        do
            local dy = -2
            while dy <= 2 do
                do
                    local dx = -2
                    while dx <= 2 do
                        self:setFunctionModule(
                            x + dx,
                            y + dy,
                            math.max(
                                math.abs(dx),
                                math.abs(dy)
                            ) ~= 1
                        )
                        dx = dx + 1
                    end
                end
                dy = dy + 1
            end
        end
    end
    function QrCode.prototype.setFunctionModule(self, x, y, isDark)
        self.modules[y + 1][x + 1] = isDark
        self.isFunction[y + 1][x + 1] = true
    end
    function QrCode.prototype.addEccAndInterleave(self, data)
        local ver = self.version
        local ecl = self.errorCorrectionLevel
        if #data ~= qrcodegen.QrCode:getNumDataCodewords(ver, ecl) then
            error(
                __TS__New(RangeError, "Invalid argument"),
                0
            )
        end
        local numBlocks = qrcodegen.QrCode.NUM_ERROR_CORRECTION_BLOCKS[ecl.ordinal + 1][ver + 1]
        local blockEccLen = qrcodegen.QrCode.ECC_CODEWORDS_PER_BLOCK[ecl.ordinal + 1][ver + 1]
        local rawCodewords = math.floor(qrcodegen.QrCode:getNumRawDataModules(ver) / 8)
        local numShortBlocks = numBlocks - rawCodewords % numBlocks
        local shortBlockLen = math.floor(rawCodewords / numBlocks)
        local blocks = {}
        local rsDiv = qrcodegen.QrCode:reedSolomonComputeDivisor(blockEccLen)
        do
            local i = 0
            local k = 0
            while i < numBlocks do
                local dat = __TS__ArraySlice(data, k, k + shortBlockLen - blockEccLen + (i < numShortBlocks and 0 or 1))
                k = k + #dat
                local ecc = qrcodegen.QrCode:reedSolomonComputeRemainder(dat, rsDiv)
                if i < numShortBlocks then
                    dat[#dat + 1] = 0
                end
                blocks[#blocks + 1] = __TS__ArrayConcat(dat, ecc)
                i = i + 1
            end
        end
        local result = {}
        do
            local i = 0
            while i < #blocks[1] do
                __TS__ArrayForEach(
                    blocks,
                    function(____, block, j)
                        if i ~= shortBlockLen - blockEccLen or j >= numShortBlocks then
                            result[#result + 1] = block[i + 1]
                        end
                    end
                )
                i = i + 1
            end
        end
        ____assert(nil, #result == rawCodewords)
        return result
    end
    function QrCode.prototype.drawCodewords(self, data)
        if #data ~= math.floor(qrcodegen.QrCode:getNumRawDataModules(self.version) / 8) then
            error(
                __TS__New(RangeError, "Invalid argument"),
                0
            )
        end
        local i = 0
        do
            local right = self.size - 1
            while right >= 1 do
                if right == 6 then
                    right = 5
                end
                do
                    local vert = 0
                    while vert < self.size do
                        do
                            local j = 0
                            while j < 2 do
                                local x = right - j
                                local upward = bit32.band(right + 1, 2) == 0
                                local y = upward and self.size - 1 - vert or vert
                                if not self.isFunction[y + 1][x + 1] and i < #data * 8 then
                                    self.modules[y + 1][x + 1] = getBit(
                                        nil,
                                        data[bit32.rshift(i, 3) + 1],
                                        7 - bit32.band(i, 7)
                                    )
                                    i = i + 1
                                end
                                j = j + 1
                            end
                        end
                        vert = vert + 1
                    end
                end
                right = right - 2
            end
        end
        ____assert(nil, i == #data * 8)
    end
    function QrCode.prototype.applyMask(self, mask)
        if mask < 0 or mask > 7 then
            error(
                __TS__New(RangeError, "Mask value out of range"),
                0
            )
        end
        do
            local y = 0
            while y < self.size do
                do
                    local x = 0
                    while x < self.size do
                        local invert
                        repeat
                            local ____switch70 = mask
                            local ____cond70 = ____switch70 == 0
                            if ____cond70 then
                                invert = (x + y) % 2 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 1
                            if ____cond70 then
                                invert = y % 2 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 2
                            if ____cond70 then
                                invert = x % 3 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 3
                            if ____cond70 then
                                invert = (x + y) % 3 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 4
                            if ____cond70 then
                                invert = (math.floor(x / 3) + math.floor(y / 2)) % 2 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 5
                            if ____cond70 then
                                invert = x * y % 2 + x * y % 3 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 6
                            if ____cond70 then
                                invert = (x * y % 2 + x * y % 3) % 2 == 0
                                break
                            end
                            ____cond70 = ____cond70 or ____switch70 == 7
                            if ____cond70 then
                                invert = ((x + y) % 2 + x * y % 3) % 2 == 0
                                break
                            end
                            do
                                error(
                                    __TS__New(Error, "Unreachable"),
                                    0
                                )
                            end
                        until true
                        if not self.isFunction[y + 1][x + 1] and invert then
                            self.modules[y + 1][x + 1] = not self.modules[y + 1][x + 1]
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
    end
    function QrCode.prototype.getPenaltyScore(self)
        local result = 0
        do
            local y = 0
            while y < self.size do
                local runColor = false
                local runX = 0
                local runHistory = {
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0
                }
                do
                    local x = 0
                    while x < self.size do
                        if self.modules[y + 1][x + 1] == runColor then
                            runX = runX + 1
                            if runX == 5 then
                                result = result + qrcodegen.QrCode.PENALTY_N1
                            elseif runX > 5 then
                                result = result + 1
                            end
                        else
                            self:finderPenaltyAddHistory(runX, runHistory)
                            if not runColor then
                                result = result + self:finderPenaltyCountPatterns(runHistory) * qrcodegen.QrCode.PENALTY_N3
                            end
                            runColor = self.modules[y + 1][x + 1]
                            runX = 1
                        end
                        x = x + 1
                    end
                end
                result = result + self:finderPenaltyTerminateAndCount(runColor, runX, runHistory) * qrcodegen.QrCode.PENALTY_N3
                y = y + 1
            end
        end
        do
            local x = 0
            while x < self.size do
                local runColor = false
                local runY = 0
                local runHistory = {
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0
                }
                do
                    local y = 0
                    while y < self.size do
                        if self.modules[y + 1][x + 1] == runColor then
                            runY = runY + 1
                            if runY == 5 then
                                result = result + qrcodegen.QrCode.PENALTY_N1
                            elseif runY > 5 then
                                result = result + 1
                            end
                        else
                            self:finderPenaltyAddHistory(runY, runHistory)
                            if not runColor then
                                result = result + self:finderPenaltyCountPatterns(runHistory) * qrcodegen.QrCode.PENALTY_N3
                            end
                            runColor = self.modules[y + 1][x + 1]
                            runY = 1
                        end
                        y = y + 1
                    end
                end
                result = result + self:finderPenaltyTerminateAndCount(runColor, runY, runHistory) * qrcodegen.QrCode.PENALTY_N3
                x = x + 1
            end
        end
        do
            local y = 0
            while y < self.size - 1 do
                do
                    local x = 0
                    while x < self.size - 1 do
                        local color = self.modules[y + 1][x + 1]
                        if color == self.modules[y + 1][x + 1 + 1] and color == self.modules[y + 1 + 1][x + 1] and color == self.modules[y + 1 + 1][x + 1 + 1] then
                            result = result + qrcodegen.QrCode.PENALTY_N2
                        end
                        x = x + 1
                    end
                end
                y = y + 1
            end
        end
        local dark = 0
        for ____, row in ipairs(self.modules) do
            dark = __TS__ArrayReduce(
                row,
                function(____, sum, color) return sum + (color and 1 or 0) end,
                dark
            )
        end
        local total = self.size * self.size
        local k = math.ceil(math.abs(dark * 20 - total * 10) / total) - 1
        ____assert(nil, 0 <= k and k <= 9)
        result = result + k * qrcodegen.QrCode.PENALTY_N4
        ____assert(nil, 0 <= result and result <= 2568888)
        return result
    end
    function QrCode.prototype.getAlignmentPatternPositions(self)
        if self.version == 1 then
            return {}
        else
            local numAlign = math.floor(self.version / 7) + 2
            local step = self.version == 32 and 26 or math.ceil((self.version * 4 + 4) / (numAlign * 2 - 2)) * 2
            local result = {6}
            do
                local pos = self.size - 7
                while #result < numAlign do
                    __TS__ArraySplice(result, 1, 0, pos)
                    pos = pos - step
                end
            end
            return result
        end
    end
    function QrCode.getNumRawDataModules(self, ver)
        if ver < qrcodegen.QrCode.MIN_VERSION or ver > qrcodegen.QrCode.MAX_VERSION then
            error(
                __TS__New(RangeError, "Version number out of range"),
                0
            )
        end
        local result = (16 * ver + 128) * ver + 64
        if ver >= 2 then
            local numAlign = math.floor(ver / 7) + 2
            result = result - ((25 * numAlign - 10) * numAlign - 55)
            if ver >= 7 then
                result = result - 36
            end
        end
        ____assert(nil, 208 <= result and result <= 29648)
        return result
    end
    function QrCode.getNumDataCodewords(self, ver, ecl)
        return math.floor(qrcodegen.QrCode:getNumRawDataModules(ver) / 8) - qrcodegen.QrCode.ECC_CODEWORDS_PER_BLOCK[ecl.ordinal + 1][ver + 1] * qrcodegen.QrCode.NUM_ERROR_CORRECTION_BLOCKS[ecl.ordinal + 1][ver + 1]
    end
    function QrCode.reedSolomonComputeDivisor(self, degree)
        if degree < 1 or degree > 255 then
            error(
                __TS__New(RangeError, "Degree out of range"),
                0
            )
        end
        local result = {}
        do
            local i = 0
            while i < degree - 1 do
                result[#result + 1] = 0
                i = i + 1
            end
        end
        result[#result + 1] = 1
        local root = 1
        do
            local i = 0
            while i < degree do
                do
                    local j = 0
                    while j < #result do
                        result[j + 1] = qrcodegen.QrCode:reedSolomonMultiply(result[j + 1], root)
                        if j + 1 < #result then
                            local ____result_5, ____temp_6 = result, j + 1
                            ____result_5[____temp_6] = bit32.bxor(____result_5[____temp_6], result[j + 1 + 1])
                        end
                        j = j + 1
                    end
                end
                root = qrcodegen.QrCode:reedSolomonMultiply(root, 2)
                i = i + 1
            end
        end
        return result
    end
    function QrCode.reedSolomonComputeRemainder(self, data, divisor)
        local result = __TS__ArrayMap(
            divisor,
            function(____, _) return 0 end
        )
        for ____, b in ipairs(data) do
            local factor = bit32.bxor(
                b,
                table.remove(result, 1)
            )
            result[#result + 1] = 0
            __TS__ArrayForEach(
                divisor,
                function(____, coef, i)
                    local ____result_7, ____temp_8 = result, i + 1
                    local ____result_index_9 = bit32.bxor(
                        ____result_7[____temp_8],
                        qrcodegen.QrCode:reedSolomonMultiply(coef, factor)
                    )
                    ____result_7[____temp_8] = ____result_index_9
                    return ____result_index_9
                end
            )
        end
        return result
    end
    function QrCode.reedSolomonMultiply(self, x, y)
        if bit32.rshift(x, 8) ~= 0 or bit32.rshift(y, 8) ~= 0 then
            error(
                __TS__New(RangeError, "Byte out of range"),
                0
            )
        end
        local z = 0
        do
            local i = 7
            while i >= 0 do
                z = bit32.bxor(
                    bit32.lshift(z, 1),
                    bit32.rshift(z, 7) * 285
                )
                z = bit32.bxor(
                    z,
                    bit32.band(
                        bit32.rshift(y, i),
                        1
                    ) * x
                )
                i = i - 1
            end
        end
        ____assert(
            nil,
            bit32.rshift(z, 8) == 0
        )
        return z
    end
    function QrCode.prototype.finderPenaltyCountPatterns(self, runHistory)
        local n = runHistory[2]
        ____assert(nil, n <= self.size * 3)
        local core = n > 0 and runHistory[3] == n and runHistory[4] == n * 3 and runHistory[5] == n and runHistory[6] == n
        return (core and runHistory[1] >= n * 4 and runHistory[7] >= n and 1 or 0) + (core and runHistory[7] >= n * 4 and runHistory[1] >= n and 1 or 0)
    end
    function QrCode.prototype.finderPenaltyTerminateAndCount(self, currentRunColor, currentRunLength, runHistory)
        if currentRunColor then
            self:finderPenaltyAddHistory(currentRunLength, runHistory)
            currentRunLength = 0
        end
        currentRunLength = currentRunLength + self.size
        self:finderPenaltyAddHistory(currentRunLength, runHistory)
        return self:finderPenaltyCountPatterns(runHistory)
    end
    function QrCode.prototype.finderPenaltyAddHistory(self, currentRunLength, runHistory)
        if runHistory[1] == 0 then
            currentRunLength = currentRunLength + self.size
        end
        table.remove(runHistory)
        __TS__ArrayUnshift(runHistory, currentRunLength)
    end
    QrCode.MIN_VERSION = 1
    QrCode.MAX_VERSION = 40
    QrCode.PENALTY_N1 = 3
    QrCode.PENALTY_N2 = 3
    QrCode.PENALTY_N3 = 40
    QrCode.PENALTY_N4 = 10
    QrCode.ECC_CODEWORDS_PER_BLOCK = {{
        -1,
        7,
        10,
        15,
        20,
        26,
        18,
        20,
        24,
        30,
        18,
        20,
        24,
        26,
        30,
        22,
        24,
        28,
        30,
        28,
        28,
        28,
        28,
        30,
        30,
        26,
        28,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30
    }, {
        -1,
        10,
        16,
        26,
        18,
        24,
        16,
        18,
        22,
        22,
        26,
        30,
        22,
        22,
        24,
        24,
        28,
        28,
        26,
        26,
        26,
        26,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28,
        28
    }, {
        -1,
        13,
        22,
        18,
        26,
        18,
        24,
        18,
        22,
        20,
        24,
        28,
        26,
        24,
        20,
        30,
        24,
        28,
        28,
        26,
        30,
        28,
        30,
        30,
        30,
        30,
        28,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30
    }, {
        -1,
        17,
        28,
        22,
        16,
        22,
        28,
        26,
        26,
        24,
        28,
        24,
        28,
        22,
        24,
        24,
        30,
        28,
        28,
        26,
        28,
        30,
        24,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30,
        30
    }}
    QrCode.NUM_ERROR_CORRECTION_BLOCKS = {{
        -1,
        1,
        1,
        1,
        1,
        1,
        2,
        2,
        2,
        2,
        4,
        4,
        4,
        4,
        4,
        6,
        6,
        6,
        6,
        7,
        8,
        8,
        9,
        9,
        10,
        12,
        12,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        19,
        20,
        21,
        22,
        24,
        25
    }, {
        -1,
        1,
        1,
        1,
        2,
        2,
        4,
        4,
        4,
        5,
        5,
        5,
        8,
        9,
        9,
        10,
        10,
        11,
        13,
        14,
        16,
        17,
        17,
        18,
        20,
        21,
        23,
        25,
        26,
        28,
        29,
        31,
        33,
        35,
        37,
        38,
        40,
        43,
        45,
        47,
        49
    }, {
        -1,
        1,
        1,
        2,
        2,
        4,
        4,
        6,
        6,
        8,
        8,
        8,
        10,
        12,
        16,
        12,
        17,
        16,
        18,
        21,
        20,
        23,
        23,
        25,
        27,
        29,
        34,
        34,
        35,
        38,
        40,
        43,
        45,
        48,
        51,
        53,
        56,
        59,
        62,
        65,
        68
    }, {
        -1,
        1,
        1,
        2,
        4,
        4,
        4,
        5,
        6,
        8,
        8,
        11,
        11,
        16,
        16,
        18,
        16,
        19,
        21,
        25,
        25,
        25,
        34,
        30,
        32,
        35,
        37,
        40,
        42,
        45,
        48,
        51,
        54,
        57,
        60,
        63,
        66,
        70,
        74,
        77,
        81
    }}
    qrcodegen.QrSegment = __TS__Class()
    local QrSegment = qrcodegen.QrSegment
    QrSegment.name = "QrSegment"
    function QrSegment.prototype.____constructor(self, mode, numChars, bitData)
        self.mode = mode
        self.numChars = numChars
        self.bitData = bitData
        if numChars < 0 then
            error(
                __TS__New(RangeError, "Invalid argument"),
                0
            )
        end
        self.bitData = __TS__ArraySlice(bitData)
    end
    function QrSegment.makeBytes(self, data)
        local bb = {}
        for ____, b in ipairs(data) do
            appendBits(nil, b, 8, bb)
        end
        return __TS__New(qrcodegen.QrSegment, qrcodegen.QrSegment.Mode.BYTE, #data, bb)
    end
    function QrSegment.makeNumeric(self, digits)
        local bb = {}
        do
            local i = 0
            while i < #digits do
                local n = math.min(#digits - i, 3)
                appendBits(
                    nil,
                    __TS__ParseInt(
                        __TS__StringSubstr(digits, i, n),
                        10
                    ),
                    n * 3 + 1,
                    bb
                )
                i = i + n
            end
        end
        return __TS__New(qrcodegen.QrSegment, qrcodegen.QrSegment.Mode.NUMERIC, #digits, bb)
    end
    function QrSegment.makeAlphanumeric(self, text)
        local bb = {}
        local i
        do
            i = 0
            while i + 2 <= #text do
                local temp = ((string.find(
                    qrcodegen.QrSegment.ALPHANUMERIC_CHARSET,
                    __TS__StringCharAt(text, i),
                    nil,
                    true
                ) or 0) - 1) * 45
                temp = temp + ((string.find(
                    qrcodegen.QrSegment.ALPHANUMERIC_CHARSET,
                    __TS__StringCharAt(text, i + 1),
                    nil,
                    true
                ) or 0) - 1)
                appendBits(nil, temp, 11, bb)
                i = i + 2
            end
        end
        if i < #text then
            appendBits(
                nil,
                (string.find(
                    qrcodegen.QrSegment.ALPHANUMERIC_CHARSET,
                    __TS__StringCharAt(text, i),
                    nil,
                    true
                ) or 0) - 1,
                6,
                bb
            )
        end
        return __TS__New(qrcodegen.QrSegment, qrcodegen.QrSegment.Mode.ALPHANUMERIC, #text, bb)
    end
    function QrSegment.makeSegments(self, text)
        if text == "" then
            return {}
        end
        return {qrcodegen.QrSegment:makeAlphanumeric(text)}
    end
    function QrSegment.makeEci(self, assignVal)
        local bb = {}
        if assignVal < 0 then
            error(
                __TS__New(RangeError, "ECI assignment value out of range"),
                0
            )
        elseif assignVal < bit32.lshift(1, 7) then
            appendBits(nil, assignVal, 8, bb)
        elseif assignVal < bit32.lshift(1, 14) then
            appendBits(nil, 2, 2, bb)
            appendBits(nil, assignVal, 14, bb)
        elseif assignVal < 1000000 then
            appendBits(nil, 6, 3, bb)
            appendBits(nil, assignVal, 21, bb)
        else
            error(
                __TS__New(RangeError, "ECI assignment value out of range"),
                0
            )
        end
        return __TS__New(qrcodegen.QrSegment, qrcodegen.QrSegment.Mode.ECI, 0, bb)
    end
    function QrSegment.prototype.getData(self)
        return __TS__ArraySlice(self.bitData)
    end
    function QrSegment.getTotalBits(self, segs, version)
        local result = 0
        for ____, seg in ipairs(segs) do
            local ccbits = seg.mode:numCharCountBits(version)
            if seg.numChars >= bit32.lshift(1, ccbits) then
                return math.huge
            end
            result = result + (4 + ccbits + #seg.bitData)
        end
        return result
    end
    function QrSegment.toUtf8ByteArray(self, str)
        str = encodeURI(nil, str)
        local result = {}
        do
            local i = 0
            while i < #str do
                if __TS__StringCharAt(str, i) ~= "%" then
                    result[#result + 1] = __TS__StringCharCodeAt(str, i)
                else
                    result[#result + 1] = __TS__ParseInt(
                        __TS__StringSubstr(str, i + 1, 2),
                        16
                    )
                    i = i + 2
                end
                i = i + 1
            end
        end
        return result
    end
    QrSegment.ALPHANUMERIC_CHARSET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:"
end
qrcodegen = qrcodegen or ({})
do
    qrcodegen.QrCode = qrcodegen.QrCode or ({})
    local QrCode = qrcodegen.QrCode
    do
        QrCode.Ecc = __TS__Class()
        local Ecc = QrCode.Ecc
        Ecc.name = "Ecc"
        function Ecc.prototype.____constructor(self, ordinal, formatBits)
            self.ordinal = ordinal
            self.formatBits = formatBits
        end
        Ecc.LOW = __TS__New(QrCode.Ecc, 0, 1)
        Ecc.MEDIUM = __TS__New(QrCode.Ecc, 1, 0)
        Ecc.QUARTILE = __TS__New(QrCode.Ecc, 2, 3)
        Ecc.HIGH = __TS__New(QrCode.Ecc, 3, 2)
    end
end
qrcodegen = qrcodegen or ({})
do
    local QrSegment
    qrcodegen.QrSegment = qrcodegen.QrSegment or ({})
    QrSegment = qrcodegen.QrSegment
    do
        QrSegment.Mode = __TS__Class()
        local Mode = QrSegment.Mode
        Mode.name = "Mode"
        function Mode.prototype.____constructor(self, modeBits, numBitsCharCount)
            self.modeBits = modeBits
            self.numBitsCharCount = numBitsCharCount
        end
        function Mode.prototype.numCharCountBits(self, ver)
            return self.numBitsCharCount[math.floor((ver + 7) / 17) + 1]
        end
        Mode.NUMERIC = __TS__New(QrSegment.Mode, 1, {10, 12, 14})
        Mode.ALPHANUMERIC = __TS__New(QrSegment.Mode, 2, {9, 11, 13})
        Mode.BYTE = __TS__New(QrSegment.Mode, 4, {8, 16, 16})
        Mode.KANJI = __TS__New(QrSegment.Mode, 8, {8, 10, 12})
        Mode.ECI = __TS__New(QrSegment.Mode, 7, {0, 0, 0})
    end
end
 end,
}
return require("qr", ...)
