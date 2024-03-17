local Skin = {
  self = nil,
  Img_Bg = {
    self = nil,
    Img_Bg_Right = nil,
    Img_BotMask = nil,
    Group_Left = {
      self = nil,
      Group_Spine = {
        self = nil,
        Img_MinionBg = {self = nil, Spine_MiniSize = nil},
        Spine_NormalSize = nil
      },
      Group_Bottom = {
        self = nil,
        Txt_SkinNameEN = nil,
        Txt_SkinName = nil,
        Txt_SkinDesc = nil,
        Btn_Look = nil,
        Txt_Live2D = nil,
        Img_TxtLine = nil,
        Img_Live2dBg = {
          self = nil,
          Txt_Off = nil,
          Txt_On = nil,
          Img_On = nil,
          Btn_Click = nil
        }
      }
    },
    Group_Right = {
      self = nil,
      Img_Frame = {
        self = nil,
        Img_Line = {self = nil, Img_Line = nil},
        Img_OwnedBg = {
          self = nil,
          Txt_SkinNum = nil,
          Txt_Owned = nil
        },
        Img_ = nil,
        Txt_SkinList = nil,
        ScrollGrid_SkinList = {
          self = nil,
          grid = {
            self = nil,
            Img_White = nil,
            Btn_SkinBg = {
              self = nil,
              Img_SkinFrame = {
                self = nil,
                Img_FrameMask = {self = nil, Img_Belonging = nil},
                Img_SkinNameBg = {self = nil, Txt_ = nil},
                Img_InUsingBg = {self = nil, Txt_ = nil}
              },
              Img_LockMask = nil,
              Img_Selected = nil
            },
            Img_Selected = nil,
            Img_Selected2 = nil
          }
        }
      },
      Group_HoldingStatus = {
        self = nil,
        Btn_On = {
          self = nil,
          Img_Bg = nil,
          Group_Buy = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Group_Bp = {self = nil, Txt_ = nil},
          Group_Wear = {
            self = nil,
            Img_Bg = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Img_Off = {
            self = nil,
            Group_NotOwned = {self = nil, Txt_ = nil},
            Group_InUsing = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            },
            Group_Awake = {self = nil, Txt_ = nil}
          }
        },
        Txt_Tips = nil
      }
    }
  },
  Sprite_Background = nil,
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Group_Txt = {
        self = nil,
        icon = nil,
        Txt_ = nil
      }
    },
    Group_Help = {
      self = nil,
      bg = nil,
      Group_Tips = {
        self = nil,
        Img_Tips = nil,
        Txt_Tips = nil
      },
      Group_window = {
        self = nil,
        bg = nil,
        Group_title = {
          self = nil,
          Img_icon = nil,
          Txt_title = nil
        },
        Group_txt = {self = nil, Txt_ = nil},
        Group_tabList = {
          self = nil,
          ScrollGrid_list = {
            self = nil,
            grid = {
              self = nil,
              Group_on = {
                self = nil,
                bg = nil,
                Txt_ = nil
              },
              Group_off = {self = nil, Txt_ = nil}
            }
          }
        }
      }
    }
  }
}
return Skin
