local OrderStartBattle = require("Guide/OrderStartBattle")
local OrderDialog = require("Guide/OrderDialog")
local OrderFocus = require("Guide/OrderFocus")
local OrderCloseFocus = require("Guide/OrderCloseFocus")
local OrderTip = require("Guide/OrderTip")
local OrderCloseTip = require("Guide/OrderCloseTip")
local OrderOpenPanel = require("Guide/OrderOpenPanel")
local OrderChapterFocusLevel = require("Guide/OrderChapterFocusLevel")
local OrderClickButton = require("Guide/OrderClickButton")
local SetQuestTrace = require("Guide/SetQuestTrace")
local OrderUIFocus = require("Guide/OrderUIFocus")
local OrderRefreshGuideNo = require("Guide/OrderRefreshGuideNo")
local OrderSetPanel = require("Guide/OrderSetPanel")
local OrderDelay = require("Guide/OrderDelay")
local OrderWaitAnimatorTrigger = require("Guide/OrderWaitAnimatorTrigger")
local OrderCloseCurrentPanel = require("Guide/OrderCloseCurrentPanel")
local OrderGoHome = require("Guide/OrderGoHome")
local OrderCloseUIDrag = require("Guide/OrderCloseUIDrag")
local OrderClearGuideTriggerKeyCache = require("Guide/OrderClearGuideTriggerKeyCache")
local OrderSavePanelTriggerNo = require("Guide/OrderSavePanelTriggerNo")
local OrderCheckProtocolParam = require("Guide/OrderCheckProtocolParam")
local OrderConditionJumpIndex = require("Guide/OrderConditionJumpIndex")
local OrderRotateCamView = require("Guide/OrderRotateCamView")
local OrderCloseGuidanceRotation = require("Guide/OrderCloseGuidanceRotation")
local OrderPicture = require("Guide/OrderPicture")
local OrderTag = require("Guide/OrderTag")
local OrderForceDrive = require("Guide/OrderForceDrive")
local OrderCompleteQuest = require("Guide/OrderCompleteQuest")
local OrderFocusFurniture = require("Guide/OrderFocusFurniture")
local OrderUIFocusCharacter = require("Guide/OrderUIFocusCharacter")
local OrderUIFocusEmptySquads = require("Guide/OrderUIFocusEmptySquads")
local OrderCamera = require("Guide/OrderCamera")
local OrderUIFocusGoods = require("Guide/OrderUIFocusGoods")
local OrderUIFocusScrollView = require("Guide/OrderUIFocusScrollView")
local currentOrder
local currentGuideCAId = 0
local ClassMod = {
  ["开始战斗"] = function()
    return OrderStartBattle
  end,
  ["对话"] = function()
    return OrderDialog
  end,
  ["指定位置高亮"] = function()
    return OrderFocus
  end,
  ["关闭指定位置高亮"] = function()
    return OrderCloseFocus
  end,
  ["提示"] = function()
    return OrderTip
  end,
  ["关闭提示"] = function()
    return OrderCloseTip
  end,
  ["打开面板"] = function()
    return OrderOpenPanel
  end,
  ["指定关卡居中"] = function()
    return OrderChapterFocusLevel
  end,
  ["点击按钮"] = function()
    return OrderClickButton
  end,
  ["设置任务追踪"] = function()
    return SetQuestTrace
  end,
  ["指定UI高亮"] = function()
    return OrderUIFocus
  end,
  ["更新引导序号"] = function()
    return OrderRefreshGuideNo
  end,
  ["设置UI面板"] = function()
    return OrderSetPanel
  end,
  ["延迟"] = function()
    return OrderDelay
  end,
  ["等待帧事件触发"] = function()
    return OrderWaitAnimatorTrigger
  end,
  ["关闭当前界面"] = function()
    return OrderCloseCurrentPanel
  end,
  ["返回主界面"] = function()
    return OrderGoHome
  end,
  ["关闭UI拖动"] = function()
    return OrderCloseUIDrag
  end,
  ["清除帧事件缓存"] = function()
    return OrderClearGuideTriggerKeyCache
  end,
  ["保存面板触发引导序号"] = function()
    return OrderSavePanelTriggerNo
  end,
  ["检测协议参数"] = function()
    return OrderCheckProtocolParam
  end,
  ["IFELSE跳转"] = function()
    return OrderConditionJumpIndex
  end,
  ["转动视角"] = function()
    return OrderRotateCamView
  end,
  ["关闭转动视角"] = function()
    return OrderCloseGuidanceRotation
  end,
  ["图片教学"] = function()
    return OrderPicture
  end,
  ["标签"] = function()
    return OrderTag
  end,
  ["强制开车"] = function()
    return OrderForceDrive
  end,
  ["完成任务"] = function()
    return OrderCompleteQuest
  end,
  ["聚焦家具"] = function()
    return OrderFocusFurniture
  end,
  ["聚焦角色并高亮"] = function()
    return OrderUIFocusCharacter
  end,
  ["编队空角色位高亮"] = function()
    return OrderUIFocusEmptySquads
  end,
  ["相机"] = function()
    return OrderCamera
  end,
  ["聚焦货物并高亮"] = function()
    return OrderUIFocusGoods
  end,
  ["ScrollView聚焦"] = function()
    return OrderUIFocusScrollView
  end
}
local GuideOrderController = {
  ExcuteOrder = function(orderId)
    local orderCA = PlayerData:GetFactoryData(orderId, "GuideOrderFactory")
    currentOrder = nil
    if orderCA ~= nil then
      currentOrder = ClassMod[orderCA.mod]()
      currentOrder:OnStart(orderCA)
    end
  end,
  IsCurrentOrderFinish = function()
    if currentOrder == nil then
      return true
    end
    return currentOrder:IsFinish()
  end,
  AnimatorTrigger = function(triggerKey)
    PlayerData.TempCache.GuideTriggerKey = triggerKey
    if currentOrder == nil then
      return true
    end
    if currentOrder.AnimatorTrigger ~= nil and currentOrder:AnimatorTrigger(triggerKey) then
      PlayerData.TempCache.GuideTriggerKey = nil
    end
  end,
  GetJumpToOrderId = function()
    if currentOrder == nil then
      return -1
    end
    if currentOrder.GetJumpToOrderId ~= nil then
      return currentOrder:GetJumpToOrderId()
    else
      return -1
    end
  end,
  LuaCheckCanExecute = function(guideId)
    currentGuideCAId = guideId
    local ca = PlayerData:GetFactoryData(guideId)
    if ca.scene and ca.scene ~= "" then
      return ca.scene == MainManager.bgSceneName
    end
    return true
  end
}

function GuideOrderController:CurrentOrderNotNil()
  return currentOrder ~= nil
end

function GuideOrderController:GetCurrentGuideCAId()
  return currentGuideCAId
end

return GuideOrderController
