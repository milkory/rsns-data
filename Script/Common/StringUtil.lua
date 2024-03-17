local unpack = unpack or table.unpack
local split = function(split_string, separator)
  local nFindStartIndex = 1
  local nSplitIndex = 1
  local nSplitArray = {}
  while true do
    local nFindLastIndex = string.find(split_string, separator, nFindStartIndex)
    if not nFindLastIndex then
      nSplitArray[nSplitIndex] = string.sub(split_string, nFindStartIndex, string.len(split_string))
      break
    end
    nSplitArray[nSplitIndex] = string.sub(split_string, nFindStartIndex, nFindLastIndex - 1)
    nFindStartIndex = nFindLastIndex + string.len(separator)
    nSplitIndex = nSplitIndex + 1
  end
  return nSplitArray
end
local join = function(join_table, joiner)
  if #join_table == 0 then
    return ""
  end
  local fmt = "%s"
  for i = 2, #join_table do
    fmt = fmt .. joiner .. "%s"
  end
  return string.format(fmt, unpack(join_table))
end
local contains = function(target_string, pattern, plain)
  plain = plain or true
  local find_pos_begin, find_pos_end = string.find(target_string, pattern, 1, plain)
  return find_pos_begin ~= nil
end
local startswith = function(target_string, start_pattern, plain)
  plain = plain or true
  local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, 1, plain)
  return find_pos_begin == 1
end
local endswith = function(target_string, start_pattern, plain)
  plain = plain or true
  local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, -#start_pattern, plain)
  return find_pos_end == #target_string
end
local lastIndexOf = function(target_string, target_char)
  local count = 0
  for i = 1, #target_string do
    local char = string.sub(target_string, i, i)
    if char == target_char then
      count = i
    end
  end
  return count
end
local nilorempty = function(target_string)
  return target_string == nil or #target_string == 0
end
local getLength = function(inputStr)
  if not inputStr or type(inputStr) ~= "string" or #inputStr <= 0 then
    return 0
  end
  local length = 0
  local i = 1
  local cacheCharLen = {}
  while true do
    local curByte = string.byte(inputStr, i)
    local byteCount = 1
    if 239 < curByte then
      byteCount = 4
    elseif 223 < curByte then
      byteCount = 3
    elseif 128 < curByte then
      byteCount = 2
    else
      byteCount = 1
    end
    i = i + byteCount
    length = length + 1
    cacheCharLen[length] = byteCount
    if i > #inputStr then
      break
    end
  end
  return length, i - 1, cacheCharLen
end
string.split = split
string.join = join
string.contains = contains
string.startswith = startswith
string.endswith = endswith
string.nilorempty = nilorempty
string.lastIndexOf = lastIndexOf
string.getLength = getLength
