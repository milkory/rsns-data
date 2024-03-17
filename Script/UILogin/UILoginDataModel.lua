local View = require("UILogin/UILoginView")
local DataModel = {}
DataModel.CloseTip = nil
DataModel.yesFunc = nil
DataModel.noFunc = nil
DataModel.IsDown = false

function DataModel.ChangeButtonState()
  if DataModel.IsDown == true then
    View.Group_LoginAndJoin.Group_Login.Btn_Down:SetActive(true)
    View.Group_LoginAndJoin.Group_Login.Btn_Up:SetActive(false)
    View.Group_LoginAndJoin.Group_Login.Img_AccountListBG:SetActive(false)
    View.Group_LoginAndJoin.Group_Login.ScrollGrid_AccountList.self:SetActive(false)
    View.Group_LoginAndJoin.Group_Login.Btn_CloseUp:SetActive(false)
  else
    View.Group_LoginAndJoin.Group_Login.Img_AccountListBG:SetActive(true)
    View.Group_LoginAndJoin.Group_Login.Btn_Down:SetActive(false)
    View.Group_LoginAndJoin.Group_Login.Btn_Up:SetActive(true)
    if DataModel.GetAccountCount() ~= 0 then
      View.Group_LoginAndJoin.Group_Login.Btn_CloseUp:SetActive(true)
      View.Group_LoginAndJoin.Group_Login.ScrollGrid_AccountList.self:SetActive(true)
      View.Group_LoginAndJoin.Group_Login.ScrollGrid_AccountList.grid.self:SetDataCount(DataModel.GetAccountCount())
      View.Group_LoginAndJoin.Group_Login.ScrollGrid_AccountList.grid.self:RefreshAllElement()
      View.Group_LoginAndJoin.Group_Login.ScrollGrid_AccountList.grid.self:MoveToTop()
    end
  end
end

function DataModel.GetAccountList(index)
  local nameList = PlayerPrefs.GetString("AccountList")
  if nameList == "" then
    return ""
  else
    local list = Json.decode(nameList)
    if index then
      if list[index] then
        return list[index]
      else
        return ""
      end
    else
      return list
    end
  end
end

function DataModel.GetAccountCount()
  local nameList = PlayerPrefs.GetString("AccountList")
  local count = 0
  if nameList == "" then
    return count
  else
    count = table.count(Json.decode(nameList))
    return count
  end
end

function DataModel.SetSoundLanguage()
  local CVList = PlayerData:GetFactoryData(99900012).CVList
  local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
  if nowLanguage == 0 then
    nowLanguage = GameSetting.defaultSoundLanguage
  end
  SoundManager:SetRoleCVReplacePath(CVList[nowLanguage].replacePath)
end

return DataModel
