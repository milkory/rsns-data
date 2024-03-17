local mathEX = {}

function mathEX.Clamp(number, min, max)
  number = number < min and min or number
  number = max < number and max or number
  return number
end

function mathEX.pow(number, n)
  if n == 0 then
    return 1
  end
  local val = 1
  for i = 1, n do
    val = val * number
  end
  return val
end

function mathEX.roundToDecimalPlaces(num, places)
  if places == nil or places == 0 then
    return math.floor(num + 0.5)
  end
  local multiplier = 10 ^ places
  return math.floor(num * multiplier + 0.5) / multiplier
end

return mathEX
