local View = require("UIRainforestJar/UIRainforestJarView")
local DataModel = require("UIRainforestJar/UIRainforestJarDataModel")
local ViewFunction = require("UIRainforestJar/UIRainforestJarViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local ufid = Json.decode(initParams).ufid
    DataModel._init(ufid)
    local fur_id = PlayerData:GetHomeInfo().furniture[DataModel.u_fid].id
    local furCA = PlayerData:GetFactoryData(fur_id)
    local v3 = Vector3(furCA.checkCameraX, furCA.checkCameraY, furCA.checkCameraZ)
    HomeManager:CamFocusToFurniture(DataModel.u_fid, v3, furCA.checkCameraTime, false, furCA.focusCamMove, function()
    end)
    View.Group_Details.ScrollGrid_.grid.self:SetDataCount(#DataModel.skin_list)
    View.Group_Details.ScrollGrid_.grid.self:RefreshAllElement()
    View.Group_Details.ScrollGrid_.grid.self:MoveToTop()
    View.Group_Details.Group_state.Btn_change:SetActive(false)
    View.Group_Details.Group_state.Img_showing:SetActive(true)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
