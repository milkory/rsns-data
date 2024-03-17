local GridController = require("UICardYard/UICardYardGridController")
local DataModel = require("UICardYard/UICardYardDataModel")
local ViewFunction = {
  CardYard_ScrollGrid_CardYard_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    GridController.SetElement(element, elementIndex)
  end,
  CardYard_ScrollGrid_CardYard_Group_Item_Btn_Item_Click = function(btn, str)
    GridController.CardBtn(btn, tonumber(str))
  end,
  CardYard_Btn_CardYard_Click = function(btn, str)
    if DataModel.currentState == DataModel.Enum.Deck then
      return
    end
    DataModel.currentState = DataModel.Enum.Deck
    DataModel.Current = DataModel.DeckList
    GridController.RefreshGrids()
  end,
  CardYard_Btn_CardCemetery_Click = function(btn, str)
    if DataModel.currentState == DataModel.Enum.Grave then
      return
    end
    DataModel.currentState = DataModel.Enum.Grave
    DataModel.Current = DataModel.GraveyardList
    GridController.RefreshGrids()
  end,
  CardYard_Btn_Close_Click = function(btn, str)
    UIManager:GoBack()
    CBus:GetManager(CS.ManagerName.BattleControlManager):Pause(false)
  end,
  CardYard_Btn_Close_Skill_Click = function(btn, str)
    DataModel.CloseCardDes()
  end,
  CardYard_CardDesCharacter_Btn_Close_Click = function(btn, str)
  end,
  CardYard_Btn_Dictionary_Click = function(btn, str)
    local data = {hideHomeBtn = 1}
    UIManager:Open("UI/Dictionary/Dictionary", Json.encode(data))
  end,
  CardYard_Group_Left_ScrollGrid__SetGrid = function(element, elementIndex)
    local tagConfig = PlayerData:GetFactoryData(DataModel.skillTagList[elementIndex])
    element.Img_:SetSprite(tagConfig.icon)
    element.Txt_TagName:SetText(tagConfig.tagName)
    element.Txt_TagDesc:SetText(tagConfig.detail)
  end,
  CardYard_StaticGrid_Left_SetGrid = function(element, elementIndex)
    local row = DataModel.CardColorData[elementIndex]
    element:SetText(row.des)
  end
}
return ViewFunction
