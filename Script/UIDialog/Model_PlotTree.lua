local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local PlotChangeBg = require("UIDialog/Model_ChangeBg")
local PlotChangeRoleImg = require("UIDialog/Model_ChangeRoleImg")
local PlotRoleImgStatus = require("UIDialog/Model_RoleImgStatus")
local PlotCheckBox = require("UIDialog/Model_CheckBox")
local PlotJumpOrder = require("UIDialog/Model_JumpOrder")
local PlotText = require("UIDialog/Model_PlotText")
local PlotTextShow = require("UIDialog/Model_PlotTextShow")
local PlotTextHide = require("UIDialog/Model_PlotTextHide")
local PlotRoleSpine = require("UIDialog/Model_RoleSpine")
local PlotImgMove = require("UIDialog/Model_PlotImgMove")
local PlotVideo = require("UIDialog/Model_PlotVideo")
local PlotSetUI = require("UIDialog/Model_PlotSetUI")
local PlotFocus = require("UIDialog/Model_Focus")
local PlotSound = require("UIDialog/Model_Sound")
local PloatMask = require("UIDialog/Model_Mask")
local PlotChangeFace = require("UIDialog/Model_PlotChangeFace")
local PlotChangeSpine = require("UIDialog/Model_ChangeSpine")
local PlotTree = Class.New("PlotTree", base)
local classModName = {
  ["背景"] = function()
    return PlotChangeBg.New()
  end,
  ["角色"] = function()
    return PlotChangeRoleImg.New()
  end,
  ["立绘状态"] = function()
    return PlotRoleImgStatus.New()
  end,
  ["立绘移动"] = function()
    return PlotImgMove.New()
  end,
  ["复选框"] = function()
    return PlotCheckBox.New()
  end,
  ["跳跃命令"] = function()
    return PlotJumpOrder.New()
  end,
  ["文本剧情"] = function()
    return PlotText.New()
  end,
  ["显示文本"] = function()
    return PlotTextShow.New()
  end,
  ["隐藏文本"] = function()
    return PlotTextHide.New()
  end,
  ["聚焦"] = function()
    return PlotFocus.New()
  end,
  ["声音"] = function()
    return PlotSound.New()
  end,
  ["全屏遮罩"] = function()
    return PloatMask.New()
  end,
  ["切换表情"] = function()
    return PlotChangeFace.New()
  end,
  ["角色动画"] = function()
    return PlotRoleSpine.New()
  end,
  ["切换动画"] = function()
    return PlotChangeSpine.New()
  end
}
local childTable = {}
local InitPlot = function(plotid)
  local plotCA = PlayerData:GetFactoryData(plotid, "PlotFactory")
  local classMod = classModName[plotCA.mod]()
  classMod:OnStart(plotCA)
  table.insert(childTable, classMod)
end
local DoTree = function(nodes)
  for i = 1, #nodes do
    if nodes[i].plotID ~= nil then
      InitPlot(nodes[i].plotID)
    end
  end
end

function PlotTree:Ctor()
end

function PlotTree:OnStart(ca)
  DoTree(ca.plotIdList)
end

function PlotTree.GetState()
  rt = true
  for i = 1, #childTable do
    childTable[i]:OnUpdate()
    if childTable[i].GetState(childTable[i]) == false then
      rt = false
    end
  end
  return rt
end

function PlotTree:Dtor()
end

return PlotTree
