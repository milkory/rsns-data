local View = require("UIStoryFragment/UIStoryFragmentView")
local DataModel = require("UIStoryFragment/UIStoryFragmentDataModel")
local ViewFunction = {
  StoryFragment_Btn_Story_Click = function(btn, str)
    UIManager:Open(UIPath.UIDialog, Json.encode({
      id = DataModel.DialogId,
      cityMapRedRecord = true
    }))
  end,
  StoryFragment_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  StoryFragment_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  StoryFragment_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  StoryFragment_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
