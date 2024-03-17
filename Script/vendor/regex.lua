local regex = {}

function regex.checkString(s, pattern, errorMessgae)
  local new_str = string.match(s, pattern)
  return new_str == s
end

function regex.checkStringEmpty(s, errorMessgae)
end

return regex
