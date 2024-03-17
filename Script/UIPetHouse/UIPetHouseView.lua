local PetHouse = {
  self = nil,
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = {self = nil, Txt_ = nil},
    Btn_Help = {self = nil, Txt_ = nil}
  },
  Group_LeftPanel = {
    self = nil,
    Img_LeftBg = nil,
    Group_PetHouseGarbage = {
      self = nil,
      Img_Icon = nil,
      Txt_ = nil,
      Txt_Garbage = nil
    },
    Group_PetScore = {
      self = nil,
      Img_Icon = nil,
      Txt_ = nil,
      Txt_Score = nil
    },
    Group_PetFood = {
      self = nil,
      Txt_ = nil,
      Txt_PetFood = nil,
      Txt_PetConsume = nil,
      Img_NowFood = {self = nil, Img_Item = nil},
      Img_TroughBg = nil,
      Img_ResideFood = nil,
      Btn_AddFood = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      }
    }
  },
  Group_CheckPets_List = {
    self = nil,
    Img_Bg = nil,
    Group_HouseName = {
      self = nil,
      Img_HouseName = {self = nil, Txt_HouseName = nil},
      Img_HouseIcon = nil,
      Btn_Rename = {self = nil, Img_ = nil}
    },
    Btn_Manage = {
      self = nil,
      Img_ = nil,
      Img_ = nil,
      Txt_Manage = nil
    },
    StaticGrid_Rooms = {
      self = nil,
      grid = {
        self = nil,
        Group_Locked = {
          self = nil,
          Img_PetLockBg = nil,
          Img_Locked = nil,
          Txt_Locked = nil
        },
        Group_CheckIn = {
          self = nil,
          Btn_CheckIn = {
            self = nil,
            Txt_CheckIn = nil,
            Img_CheckIn = nil
          }
        },
        Group_Pet = {
          self = nil,
          Img_Bg = nil,
          Img_Pet = nil,
          Group_Name = {self = nil, Txt_Name = nil},
          Img_Path = nil,
          Group_Love = {
            self = nil,
            Img_Heart = nil,
            Txt_LoveLevel = nil,
            Txt_Love = nil,
            Img_LoveBarBg = nil,
            Img_LoveBar = nil
          },
          Btn_ = nil,
          Group_State = {
            self = nil,
            Group_Bad = {self = nil, Img_Bad = nil},
            Group_Good = {
              self = nil,
              Btn_ = nil,
              Img_Good = nil
            }
          },
          Group_Feeder = {
            self = nil,
            Btn_feeder = {
              self = nil,
              Img_AddFeeder = {self = nil, Txt_ = nil},
              Img_icon = nil
            },
            Img_mask = nil
          }
        }
      }
    }
  },
  Group_ChangeHouse = {
    self = nil,
    Btn_Left = nil,
    Btn_Right = nil
  },
  Group_ChangeName = {
    self = nil,
    Btn_Close = {self = nil, Img_ = nil},
    Img_Mask = {
      self = nil,
      Img_BG2 = nil,
      Img_BG = nil
    },
    InputField_ChangeName = {
      self = nil,
      Placeholder = nil,
      Txt_Text = nil
    },
    Txt_N = nil,
    Btn_Confirm = {
      self = nil,
      Img_Icon = nil,
      Txt_T = nil
    },
    Btn_Cancel = {
      self = nil,
      Img_Icon = nil,
      Txt_T = nil
    },
    Txt_Title = nil
  },
  Screen_AddFood = {
    self = nil,
    Btn_BG = {self = nil, Img_ = nil},
    Group_Window = {
      self = nil,
      Img_WindowBg = nil,
      Img_Head = {self = nil, Txt_ = nil},
      Img_NowFood = {self = nil, Img_Item = nil},
      Txt_ = nil,
      Txt_PetFood = nil,
      Img_TroughBg = nil,
      Img_ResideFood = nil,
      ScrollGrid_FoodList = {
        self = nil,
        grid = {
          self = nil,
          Group_Item = {
            self = nil,
            Btn_Item = nil,
            Img_Bottom = nil,
            Img_Item = nil,
            Img_Mask = nil,
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            },
            Txt_Num = nil,
            Img_Type01 = nil,
            Img_Type02 = nil,
            Img_Time = {self = nil, Txt_ = nil},
            Img_Effect = nil,
            Group_EType = {
              self = nil,
              Img_IconBg = nil,
              Img_Icon = nil
            }
          },
          Btn_AddItem = nil
        }
      }
    },
    Group_Tips = {
      self = nil,
      Img_Tips = nil,
      Txt_Tips = nil
    }
  }
}
return PetHouse
