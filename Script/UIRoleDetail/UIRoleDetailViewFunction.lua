local View = require("UIRoleDetail/UIRoleDetailView")
local DataModel = require("UIRoleDetail/UIRoleDetailDataModel")
local Clear = function()
  if DataModel.InstantiateList then
    for k, v in pairs(DataModel.InstantiateList) do
      Object.Destroy(v)
    end
  end
end
local ViewFunction = {
  RoleDetail_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    Clear()
  end
}
return ViewFunction
