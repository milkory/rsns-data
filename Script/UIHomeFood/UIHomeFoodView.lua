local HomeFood = {
  self = nil,
  Img_bg = nil,
  Img_Back = nil,
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = {self = nil, Txt_ = nil},
    Btn_Help = {self = nil, Txt_ = nil}
  },
  ScrollGrid_FoodList = {
    self = nil,
    grid = {
      self = nil,
      Node_LoveBento = {
        self = nil,
        Img_BGLoveBento = nil,
        Img_NormalIcon = nil,
        Txt_Name = nil,
        Img_NewIcon = nil,
        Img_Time = {self = nil, Txt_Days = nil},
        Group_TireLocked = {
          self = nil,
          Img_Tire = nil,
          Txt_Energy = nil
        }
      },
      Node_Free = {
        self = nil,
        Img_BGFreeOrder = nil,
        Group_Tire = {
          self = nil,
          Img_Tire = nil,
          Txt_Energy = nil
        },
        Img_Time = {self = nil, Txt_Time = nil},
        Img_UsedMask = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Img_Mask = nil,
      Img_Food = nil,
      Txt_FoodName = nil,
      Btn_Food = nil,
      Img_Picked = nil
    }
  },
  Img_TireBG = {
    self = nil,
    Img_TireIcon = nil,
    Img_TireProgressBG = nil,
    Img_TireProgress = nil,
    Txt_Energy = nil,
    Btn_MoveEnergy = nil
  },
  Group_Description = {
    self = nil,
    Txt_Name = nil,
    Group_FreeOrder = {
      self = nil,
      Txt_Date = nil,
      Img_DateIcon = nil,
      Img_Date = nil,
      Img_BG = nil,
      Txt_Des = nil,
      Group_Time = {
        self = nil,
        Txt_TimeTip = nil,
        Txt_Time = nil
      },
      Group_Tire = {
        self = nil,
        Img_Tire = nil,
        Txt_Energy = nil
      }
    },
    Group_LoveBento = {
      self = nil,
      Txt_Subtitle = nil,
      Img_LetterBG = {
        self = nil,
        Img_PicBg = {self = nil, Img_Avatar = nil},
        Txt_Content = nil,
        Txt_Name = nil,
        Img_Decoration = nil
      },
      Group_Tire = {
        self = nil,
        Img_Tire = nil,
        Txt_Energy = nil
      },
      Group_TireLocked = {
        self = nil,
        Img_Tire = nil,
        Txt_Energy = nil
      },
      Btn_Tip = {
        self = nil,
        Img_Tip = {
          self = nil,
          Btn_TipMask = {self = nil, Txt_ = nil},
          Img_Icon = nil,
          Txt_Title = nil,
          Txt_Content = nil
        }
      }
    },
    Btn_Use = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    },
    Img_Used = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    }
  },
  Group_Dialog = {self = nil, Txt_Dialog = nil}
}
return HomeFood
