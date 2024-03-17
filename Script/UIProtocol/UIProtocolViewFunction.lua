local View = require("UIProtocol/UIProtocolView")
local DataModel = require("UIProtocol/UIProtocolDataModel")
local ViewFunction = {
  Protocol_Btn_Open_Click = function(btn, str)
    Net.IsOpenTest = true
    View.Group_Protocol.self:SetActive(true)
    if not DataModel.IsOk then
      View.Group_Protocol.ScrollGrid_Protocol.grid.self:SetDataCount(#DataModel.ProtocolName + 13)
      View.Group_Protocol.ScrollGrid_Protocol.grid.self:RefreshAllElement()
    end
    DataModel.IsOk = true
  end,
  Protocol_Group_Protocol_ScrollGrid_Protocol_SetGrid = function(element, elementIndex)
    if elementIndex <= #DataModel.ProtocolName then
      element.Btn_Show.Txt_Name:SetText(DataModel.ProtocolName[elementIndex].name)
      element.Btn_Show.Txt_Show:SetText(DataModel.ProtocolName[elementIndex].desc)
      element.Btn_Show:SetClickParam(elementIndex)
    else
      element.self:SetActive(false)
    end
  end,
  Protocol_Group_Protocol_ScrollGrid_Protocol_Group_Item_Btn_Show_Click = function(btn, str)
    local index = tonumber(str)
    DataModel.Index = index
    View.Group_Send.self:SetActive(true)
    if #DataModel.ProtocolName[index].param ~= 0 then
      View.Group_Send.StaticGrid_Txt.grid.self:SetActive(true)
      View.Group_Send.StaticGrid_Txt.grid.self:SetDataCount(#DataModel.ProtocolName[index].param)
      View.Group_Send.StaticGrid_Txt.grid.self:RefreshAllElement()
    else
      View.Group_Send.StaticGrid_Txt.grid.self:SetActive(false)
    end
  end,
  Protocol_Group_Send_StaticGrid_Txt_SetGrid = function(element, elementIndex)
    if DataModel.ProtocolName[DataModel.Index].paramDesc[elementIndex] then
      element.Txt_Desc:SetText(DataModel.ProtocolName[DataModel.Index].paramDesc[elementIndex])
      element.InputField_Txt:SetText("")
    else
      element.Txt_Desc:SetText(DataModel.ProtocolName[DataModel.Index].param[elementIndex])
      element.InputField_Txt:SetText("")
    end
  end,
  Protocol_Group_Send_Btn_Send_Click = function(btn, str)
    local grid = View.Group_Send.StaticGrid_Txt.grid
    local t = {}
    for i = 1, 5 do
      local element = grid[i]
      if DataModel.ProtocolName[DataModel.Index].param[i] then
        if Trim(DataModel.ProtocolName[DataModel.Index].param[i]) == "failCb" then
          t[i] = nil
        else
          t[i] = element.InputField_Txt:GetText()
        end
      end
    end
    Net:SendProto(DataModel.ProtocolName[DataModel.Index].name, nil, table.unpack(t))
    View.Group_Send.self:SetActive(false)
  end,
  Protocol_Btn_Close_Click = function(btn, str)
    Net.IsOpenTest = false
    View.Group_Protocol.self:SetActive(false)
    View.Group_Send.self:SetActive(false)
  end
}
return ViewFunction
