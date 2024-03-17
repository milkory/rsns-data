local Group_TrainWeaponSth = {
  self = nil,
  Img_Bg = nil,
  Img_BgLighting = nil,
  Group_Top = {
    self = nil,
    Img_TitleBg = nil,
    Img_TitleIcon = nil,
    Txt_Title = nil,
    Txt_Eng = nil
  },
  Group_Left = {
    self = nil,
    Txt_ = nil,
    Img_CircleBg = {self = nil, Img_Circle = nil},
    Img_Weapon = nil,
    Group_Level = {
      self = nil,
      Img_Icon1 = nil,
      Img_Icon2 = nil,
      Txt_Text = nil,
      Txt_OldLevel = nil,
      Txt_LEVEL1 = nil,
      Img_Arrow = nil,
      Txt_NewLevel = nil,
      Txt_LEVEL2 = nil
    }
  },
  Img_icon = nil,
  Group_Right = {
    self = nil,
    Img_Bg = {
      self = nil,
      Img_Rare = nil,
      Txt_Name = nil,
      Img_Type = {self = nil, Txt_Type = nil},
      Group_GrowthAttributes = {
        self = nil,
        Img_attributeline = {
          self = nil,
          Img_1 = nil,
          Txt_Text = nil,
          Txt_English = nil
        },
        Group_SpecialEntry1 = {
          self = nil,
          Img_Icon = nil,
          Txt_Entry = nil,
          Img_Arrow = nil
        }
      },
      Group_MaterialAndBtn = {
        self = nil,
        Img_MaterialBg = {
          self = nil,
          Img_1 = nil,
          Txt_Text = nil,
          Txt_English = nil,
          Group_Item = {
            self = nil,
            Img_Dikuang = {
              self = nil,
              Group_Item = {
                self = nil,
                Btn_Item = nil,
                Img_Bottom = nil,
                Img_Item = nil,
                Txt_Num = nil,
                Img_Mask = nil
              },
              Group_Cost = {
                self = nil,
                Txt_Have = nil,
                Txt_And = nil,
                Txt_Need = nil
              }
            }
          },
          StaticGrid_Material = {
            self = nil,
            grid = {
              self = nil,
              Img_Dikuang = {
                self = nil,
                Group_Item = {
                  self = nil,
                  Btn_Item = nil,
                  Img_Bottom = nil,
                  Img_Item = nil,
                  Txt_Num = nil,
                  Img_Mask = nil
                },
                Group_Cost = {
                  self = nil,
                  Txt_Have = nil,
                  Txt_And = nil,
                  Txt_Need = nil
                }
              }
            }
          }
        },
        Btn_Strength = {
          self = nil,
          Img_Strength = nil,
          Txt_Strength = nil
        }
      }
    }
  },
  Img_HavemoneyBg = {
    self = nil,
    Img_Money = nil,
    Txt_Num = nil,
    Btn_Add = {self = nil, Txt_Add = nil}
  },
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Group_Txt = {
        self = nil,
        Img_icon = nil,
        Txt_ = nil
      }
    }
  }
}
return Group_TrainWeaponSth
