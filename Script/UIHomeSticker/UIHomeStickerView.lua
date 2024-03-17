local HomeSticker = {
  self = nil,
  Img_Bg = nil,
  Img_BGframe = nil,
  Img_Mask = nil,
  Img_Decoration1 = nil,
  Img_Decoration2 = nil,
  Img_DecorationCamera = nil,
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
  },
  Img_Frame = {self = nil, Group_HomeCharacter = nil},
  Btn_Take = {self = nil, Txt_Take = nil},
  Img_MoneyCostTip = {
    self = nil,
    Group_Cost = {
      self = nil,
      Img_MoneyIcon = nil,
      Txt_CostNum = nil
    }
  },
  Group_InviteMember = {
    self = nil,
    Img_BG = nil,
    ScrollGrid_MemberList = {
      self = nil,
      grid = {
        self = nil,
        Img_MemberBG = nil,
        Img_Member = nil,
        Btn_Select = nil,
        Img_Picekd = nil,
        Txt_Name = nil
      }
    },
    Img_Mask = nil,
    Txt_Title = nil
  },
  Group_Album = {
    self = nil,
    Img_BG = nil,
    Txt_Des = nil,
    ScrollGrid_AlbumList = {
      self = nil,
      grid = {
        self = nil,
        Img_BG = nil,
        Img_Photo = nil,
        Img_NotOwned = nil
      }
    },
    Txt_Title = nil
  },
  Img_HBP = {
    self = nil,
    Btn_HBPStore = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Img_Icon = nil,
    Txt_Num = nil
  },
  Btn_HS = {
    self = nil,
    Img_Icon = nil,
    Txt_Num = nil
  },
  SpineAnimation_ClickCamera = nil
}
return HomeSticker
