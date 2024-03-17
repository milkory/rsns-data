local View = require("UIBook/UIBookView")
local ViewFunction = require("UIBook/UIBookViewFunction")
local Role = require("UIBook/UIBookRole")
local CG = require("UIBook/UIBookCG")
local Music = require("UIBook/UIBookMusic")
local Picture = require("UIBook/UIBookPicture")
local Enemy = require("UIBook/UIBookEnemy")
local Hint = require("UIBook/UIBookHint")
local DataModel = require("UIBook/UIBookDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.HomeOpen = false
    if initParams ~= nil then
      local data = Json.decode(initParams)
      View.Group_BookMain.self:SetActive(false)
      View.Group_Roles.self:SetActive(false)
      View.Group_PC.self:SetActive(false)
      local homeInfo = PlayerData:GetHomeInfo()
      if homeInfo ~= nil and homeInfo.furniture ~= nil and homeInfo.furniture[data.ufid] ~= nil then
        local id = homeInfo.furniture[data.ufid].id
        if id == "81300137" then
          Role.Init()
          Enemy.Init()
          View.Group_Roles.self:SetActive(true)
          DataModel.HomeOpen = true
        elseif id == "81300138" then
          CG.Init(false)
          Picture.Init()
          View.Group_PC.self:SetActive(true)
          DataModel.HomeOpen = true
        end
      end
    else
      View.Group_BookMain.self:SetActive(true)
      Role.Init()
      CG.Init(initParams ~= nil)
      Music.Init()
      Picture.Init()
      Enemy.Init()
      Hint:Init()
    end
  end,
  awake = function()
    DataModel.SpineEnemyScale = View.Group_EnemyDetail.Group_Details.SpineAnimation_Enemy.transform.localScale
    DataModel.SpineEnemyPosition = View.Group_EnemyDetail.Group_Details.SpineAnimation_Enemy.transform.localPosition
  end,
  start = function()
  end,
  update = function()
    Music.RefreshValue()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
