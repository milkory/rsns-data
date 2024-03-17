local luaSafeMath = {}
local safeNumTime = 10000

function luaSafeMath.SafeNumToInt(safeNum)
  return math.floor(safeNum / safeNumTime)
end

function luaSafeMath.SafeNumToFloat(safeNum)
  return math.floor(safeNum) / safeNumTime
end

return luaSafeMath
