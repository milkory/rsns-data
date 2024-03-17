local View = require("UIProtocol/UIProtocolView")
local DataModel = require("UIProtocol/UIProtocolDataModel")
local ViewFunction = require("UIProtocol/UIProtocolViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
  end,
  awake = function()
    local name = GameSetting.luaFileAddress .. "Net/Protocol.lua"
    local content = File.ReadAllText(name)
    DataModel.ProtocolName = {}
    local test = Split(content, "end\r\n")
    for w, r in string.gmatch(content, "Protocol%[\"([%a%p]+)\"%]%s-=%s-function%s-%(([%a%,%s%_]*)%)?") do
      table.insert(DataModel.ProtocolName, {
        name = w,
        param = {}
      })
      local currDesc = test[#DataModel.ProtocolName]
      local currT = DataModel.ProtocolName[#DataModel.ProtocolName]
      currT.desc = string.match(currDesc, "desc:?%s-(.-)\n")
      if r ~= nil and r ~= "" then
        currT.param = Split(r, ",")
        currT.paramDesc = {}
        for i = 1, #currT.param do
          currT.paramDesc[i] = string.match(currDesc, Trim(currT.param[i]) .. ":?%s-(.-)\n")
        end
      end
    end
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
