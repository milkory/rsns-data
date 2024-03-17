local View = require("UIHomeFishTank/UIHomeFishTankView")
local DataModel = require("UIHomeFishTank/UIHomeFishTankDataModel")
local Controller = {}

function Controller:InitUI()
  Controller:RefreshTopDataShow()
  DataModel.CurShowType = 0
  Controller:SelectShowType(DataModel.ShowTypeEnum.Fish)
end

function Controller:SelectShowType(toType)
  View.Group_yugangUI.Img_Glass.Btn_BackGroundRight.Img_Select.self:SetActive(false)
  View.Group_yugangUI.Img_Glass.Btn_BackGroundRight.Img_Unselect.self:SetActive(false)
  DataModel.CurShowType = toType
  if toType == DataModel.ShowTypeEnum.Fish then
    View.Group_yugangUI.self:SelectPlayAnim("IN")
    View.Group_yugangUI.Btn_AllFish.Img_Select.self:SetActive(true)
    View.Group_yugangUI.Img_Glass.Btn_BackGroundRight.Img_Unselect.self:SetActive(true)
    Controller:SelectFishType(DataModel.FishType.all, true)
  elseif toType == DataModel.ShowTypeEnum.Skin then
    View.Group_yugangUI.self:SelectPlayAnim("OUT")
    View.Group_yugangUI.Btn_AllFish.Img_Select.self:SetActive(false)
    View.Group_yugangUI.Img_Glass.Btn_BackGroundRight.Img_Select.self:SetActive(true)
    View.Group_yugangUI.Btn_AllFish.Img_Unselect.self:SetActive(true)
    Controller:SelectSkin()
  end
end

function Controller:RefreshTopDataShow()
  View.Group_yugangUI.Img_RubbishBase.Txt_RubbishNum:SetText(DataModel.curRubbishNum .. "/h")
  View.Group_yugangUI.Img_CapacityBase.Txt_CapacityNum:SetText(string.format("%d/%d", DataModel.curUsedVolume, DataModel.maxVolume))
end

function Controller:SelectFishType(toType, force)
  if DataModel.CurShowType ~= DataModel.ShowTypeEnum.Fish then
    return
  end
  if not force and DataModel.curSelectType == toType then
    return
  end
  View.Group_yugangUI.Btn_AllFish.Img_Select.self:SetActive(toType == DataModel.FishType.all)
  View.Group_yugangUI.Btn_AllFish.Img_Unselect.self:SetActive(toType ~= DataModel.FishType.all)
  local btnNames = {
    [1] = "Btn_xiaoxingyu",
    [2] = "Btn_zhongxingyu",
    [3] = "Btn_daxingyu",
    [4] = "Btn_chaodaxingyu"
  }
  for k, v in pairs(btnNames) do
    local showClose = true
    if k == toType then
      showClose = false
    end
    View.Group_yugangUI.Img_Glass.Group_Button[v].Group_Open.self:SetActive(not showClose)
    View.Group_yugangUI.Img_Glass.Group_Button[v].Group_Close.self:SetActive(showClose)
  end
  DataModel.curSelectType = toType
  View.TempCo = View.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    DataModel.CurSelectFishTable = DataModel.fishData[toType]
    View.Group_yugangUI.NewScrollGrid_Yu.grid.self:SetDataCount(#DataModel.CurSelectFishTable)
    View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
    if View.TempCo then
      View.self:StopC(View.TempCo)
      View.TempCo = nil
    end
  end))
end

function Controller:SelectSkin()
  if DataModel.skinData == nil then
    DataModel.InitSkinData()
  end
  View.Group_yugangUI.NewScrollGrid_Yu.grid.self:SetDataCount(#DataModel.skinData)
  View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
end

function Controller:AddFish(id, num)
  local complete = DataModel.ChangeFishData(id, num)
  if complete then
    View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
    Controller:RefreshTopDataShow()
    if num == 1 then
      HomeCreatureManager:AddFurCreature(DataModel.curFurUfid, id)
    end
  end
end

function Controller:RemoveFish(id, num)
  local complete = DataModel.ChangeFishData(id, -num)
  if complete then
    View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
    Controller:RefreshTopDataShow()
    if num == 1 then
      HomeCreatureManager:RemoveFurCreatureById(DataModel.curFurUfid, id)
    end
  end
end

function Controller:ToSetting()
  local t = PlayerData.ServerData.user_home_info.furniture
  local ufid = HomeManager:GetFocusFurnitureUfid()
  if ufid == "" then
    ufid = DataModel.curFurUfid
  else
    DataModel.curFurUfid = ufid
  end
  local info = t[ufid]
  if info == nil then
    return
  end
  DataModel.curFurId = info.id
  View.Btn_Setting.self:SetActive(false)
  View.Group_yugangUI.self:SetActive(true)
  DataModel.InitData()
  Controller:InitUI()
end

function Controller:RevertToShowView()
  View.Group_yugangUI.self:SetActive(false)
  View.Btn_Setting.self:SetActive(true)
end

function Controller:Clear()
  local t = {}
  for k, v in pairs(DataModel.furFishData) do
    if 0 < v then
      t[k] = v
    end
  end
  for k, v in pairs(DataModel.fishChangeData) do
    if t[k] == nil then
      t[k] = 0
    end
    t[k] = t[k] + v
  end
  for k, v in pairs(t) do
    DataModel.ChangeFishData(k, -v)
  end
  View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
  Controller:RefreshTopDataShow()
  HomeCreatureManager:RemoveFurAllCreatures(DataModel.curFurUfid)
end

function Controller:Save(cb)
  local changeSkinUId
  if DataModel.curUsedSkinUId ~= DataModel.furSkinUId then
    changeSkinUId = DataModel.curUsedSkinUId
  end
  local str = ""
  for k, v in pairs(DataModel.fishChangeData) do
    if str ~= "" then
      str = str .. ","
    end
    str = str .. k .. ":" .. v
  end
  if str == "" and changeSkinUId == nil then
    if cb ~= nil then
      cb()
    end
    return
  end
  if str == "" then
    Net:SendProto("furniture.redecorate", function()
      if changeSkinUId ~= nil then
        if changeSkinUId == "" then
          PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].u_skin = nil
          if DataModel.furSkinUId ~= nil and DataModel.furSkinUId ~= "" then
            PlayerData:GetHomeInfo().furniture_skins[DataModel.furSkinUId].u_fid = ""
          end
        else
          PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].u_skin = changeSkinUId
          PlayerData:GetHomeInfo().furniture_skins[changeSkinUId].u_fid = DataModel.curFurUfid
          if DataModel.furSkinUId ~= nil and DataModel.furSkinUId ~= "" then
            PlayerData:GetHomeInfo().furniture_skins[DataModel.furSkinUId].u_fid = ""
          end
        end
      end
      DataModel.furSkinUId = DataModel.curUsedSkinUId
      if cb ~= nil then
        cb()
      end
    end, DataModel.curFurUfid, changeSkinUId)
    return
  end
  Net:SendProto("creature.place_fish", function(json)
    PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid] = json.furniture[DataModel.curFurUfid]
    for k, v in pairs(DataModel.fishChangeData) do
      local key = tostring(k)
      if PlayerData.ServerData.user_home_info.creatures[key] == nil then
        PlayerData.ServerData.user_home_info.creatures[key] = {}
        PlayerData.ServerData.user_home_info.creatures[key].num = v
      else
        PlayerData.ServerData.user_home_info.creatures[key].num = PlayerData.ServerData.user_home_info.creatures[key].num - v
      end
    end
    DataModel.fishChangeData = {}
    DataModel.furFishData = {}
    local serverFurData = json.furniture[DataModel.curFurUfid]
    if serverFurData ~= nil and serverFurData.water ~= nil and serverFurData.water.fishes ~= nil then
      for k, v in pairs(serverFurData.water.fishes) do
        DataModel.furFishData[tonumber(k)] = v
      end
    end
    if changeSkinUId ~= nil then
      if changeSkinUId == "" then
        PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].u_skin = nil
        if DataModel.furSkinUId ~= nil and DataModel.furSkinUId ~= "" then
          PlayerData:GetHomeInfo().furniture_skins[DataModel.furSkinUId].u_fid = ""
        end
      else
        PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].u_skin = changeSkinUId
        PlayerData:GetHomeInfo().furniture_skins[changeSkinUId].u_fid = DataModel.curFurUfid
        if DataModel.furSkinUId ~= nil and DataModel.furSkinUId ~= "" then
          PlayerData:GetHomeInfo().furniture_skins[DataModel.furSkinUId].u_fid = ""
        end
      end
    end
    if cb ~= nil then
      cb()
    end
    DataModel.furSkinUId = DataModel.curUsedSkinUId
  end, DataModel.curFurUfid, str, changeSkinUId)
end

function Controller:Revert()
  for k, v in pairs(DataModel.fishChangeData) do
    DataModel.ChangeFishData(k, -v)
    if 0 < -v then
      HomeCreatureManager:AddFurCreatureNum(DataModel.curFurUfid, k, -v)
    else
      HomeCreatureManager:RemoveFurCreatureNum(DataModel.curFurUfid, k, v)
    end
  end
  View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
  Controller:RefreshTopDataShow()
  Controller:RevertSkin()
end

function Controller:RevertSkin()
  if DataModel.furSkinUId ~= DataModel.curUsedSkinUId then
    local id = 0
    if DataModel.furSkinUId ~= nil and DataModel.furSkinUId ~= "" then
      id = tonumber(PlayerData:GetHomeInfo().furniture_skins[DataModel.furSkinUId].id)
    end
    HomeManager:ChangeFurnitureSkin(-1, DataModel.curFurUfid, id)
  end
end

function Controller:ChangeSkin(idx)
  local info = DataModel.skinData[idx]
  local u_skinId = info.u_skin
  local isUsed = info.isUsed
  local needSort = false
  local removeUsedData = function()
    local data = DataModel.skinData[1]
    table.remove(DataModel.skinData, 1)
    local findIdx = -1
    for k, v in pairs(DataModel.skinData) do
      if not v.isUsed and v.id == data.id then
        findIdx = k
        break
      end
    end
    if 0 < findIdx then
      local temp = DataModel.skinData[findIdx]
      temp.u_skin = data.u_skin
      temp.u_skins[data.u_skin] = 0
    else
      local t = {}
      t.id = data.id
      local ca = PlayerData:GetFactoryData(data.id, "HomeFurnitureSkinFactory")
      t.name = ca.name
      t.iconPath = ca.iconPath
      t.u_skin = data.u_skin
      t.isUsed = false
      t.u_skins = {}
      t.u_skins[data.u_skin] = 0
      table.insert(DataModel.skinData, t)
      needSort = true
    end
  end
  if u_skinId == DataModel.curUsedSkinUId then
    removeUsedData()
    HomeManager:ChangeFurnitureSkin(-1, DataModel.curFurUfid, 0)
    DataModel.curUsedSkinUId = ""
    View.Group_yugangUI.NewScrollGrid_Yu.grid.self:SetDataCount(#DataModel.skinData)
    View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
    return
  end
  local changeSkin = function()
    local success = HomeManager:ChangeFurnitureSkin(-1, DataModel.curFurUfid, info.id)
    if success then
      info.u_skins[u_skinId] = nil
      if table.count(info.u_skins) == 0 then
        table.remove(DataModel.skinData, idx)
      else
        local findSkinId
        for k, v in pairs(info.u_skins) do
          findSkinId = k
          break
        end
        info.u_skin = findSkinId
        info.isUsed = false
      end
      if DataModel.curUsedSkinUId ~= nil and DataModel.curUsedSkinUId ~= "" then
        removeUsedData()
      end
      local t = {}
      t.id = info.id
      t.name = info.name
      t.iconPath = info.iconPath
      t.isUsed = true
      t.selfUsed = true
      t.u_skin = u_skinId
      t.u_skins = {}
      t.u_skins[u_skinId] = 0
      table.insert(DataModel.skinData, 1, t)
      DataModel.curUsedSkinUId = u_skinId
      if needSort then
        DataModel.SortSkinData()
      end
      View.Group_yugangUI.NewScrollGrid_Yu.grid.self:SetDataCount(#DataModel.skinData)
      View.Group_yugangUI.NewScrollGrid_Yu.grid.self:RefreshAllElement()
    end
  end
  if not isUsed then
    changeSkin()
  else
    CommonTips.OnPrompt(GetText(80601008), nil, nil, function()
      changeSkin()
    end)
  end
end

return Controller
