local View = require("UIFile/UIFileView")
local DataModel = require("UIFile/UIFileDataModel")
local ViewFunction = require("UIFile/UIFileViewFunction")
local InitRoleStorySV = function()
  local roleStorySV = View.Group_Story.Group_Story2.transform:Find("RoleStorySV/Viewport/Content")
  local count = roleStorySV.transform.childCount
  if count == 1 then
    local origin = roleStorySV.transform:GetChild(0)
    for i = 1, 6 do
      View.self:GetRes("UI/CharacterInfo/File/RoleStoreItem", roleStorySV)
      count = count + 1
    end
  end
  View.Group_Story.Group_Story2:SetActive(true)
  View.Group_Story.Group_Story2:SetActive(false)
  local storyList = DataModel.file_cfg.StoryList
  local storyCount = #storyList
  for i = 0, count - 1 do
    local obj = roleStorySV.transform:GetChild(i)
    local btn = obj:GetComponent(typeof(CS.Seven.UIBtn))
    local desDiGroup = btn.transform:Find("Img_DesDi"):GetComponent(typeof(CS.Seven.UIImg))
    desDiGroup:SetActive(false)
    local unlock = obj:Find("Img_Lock"):GetComponent(typeof(CS.Seven.UIImg))
    if storyCount >= i + 1 then
      obj.gameObject:SetActive(true)
      unlock:SetActive(false)
      local diGroup = btn.transform:Find("Img_Di"):GetComponent(typeof(CS.Seven.UIImg))
      btn:SetBtnInteractable(false)
      btn:SetHeight(diGroup.Rect.sizeDelta.y)
      if DataModel.roleTrustLv >= storyList[i + 1].UnlockLevel then
        local selectGroup = btn.transform:Find("Img_SelectIcon"):GetComponent(typeof(CS.Seven.UIImg))
        local desTxt = btn.transform:Find("Img_DesDi/Txt_Des"):GetComponent(typeof(CS.Seven.UITxt))
        local titleTxt = btn.transform:Find("TitleTxt"):GetComponent(typeof(CS.UnityEngine.UI.Text))
        local imgNew = btn.transform:Find("Img_New")
        if PlayerData:GetPlayerPrefs("int", DataModel.roleId .. i) == 0 then
          imgNew.gameObject:SetActive(true)
        else
          imgNew.gameObject:SetActive(false)
        end
        titleTxt.text = storyList[i + 1].Title
        selectGroup:SetLocalEulerAngles(-90)
        btn:SetBtnInteractable(true)
        btn:SetClickFunction(function()
          if PlayerData:GetPlayerPrefs("int", DataModel.roleId .. i) == 0 then
            PlayerData:SetPlayerPrefs("int", DataModel.roleId .. i, 1)
            imgNew.gameObject:SetActive(false)
          end
          if desDiGroup.IsActive == false then
            local str = storyList[i + 1].des
            str = string.gsub(str, "\r", "\n")
            desTxt:SetText(str)
            desDiGroup:SetActive(true)
            local length = desTxt:GetHeight()
            selectGroup:SetLocalEulerAngles(0)
            btn:SetHeight(btn.Rect.sizeDelta.y + length + 10)
            desDiGroup:SetHeight(length + 10)
          else
            desDiGroup:SetActive(false)
            btn:SetHeight(diGroup.Rect.sizeDelta.y)
            selectGroup:SetLocalEulerAngles(-90)
          end
        end)
      else
        unlock:SetActive(true)
        do
          local txt = unlock.transform:Find("Txt_"):GetComponent(typeof(CS.Seven.UITxt))
          txt:SetText(string.format("默契等级LV%d解锁", storyList[i + 1].UnlockLevel))
        end
      end
    else
      obj.gameObject:SetActive(false)
    end
  end
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    DataModel.initData(param.roleId)
    ViewFunction.SelectFileOrSound(param.status)
    ViewFunction.InitInfoFile()
    InitRoleStorySV()
    View.Group_CommonTopLeft.Btn_Home:SetActive(not MapNeedleEventData.openInsZone)
  end,
  awake = function()
  end,
  start = function()
    DataModel.processBarWidth = View.Group_Audio.Group_Audio1.ScrollGrid_Audio1.grid[1].Btn_PlayAudio.Img_VoiceBg.Img_Wave.Rect.sizeDelta.x
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
