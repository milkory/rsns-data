local EquipForge = {
  self = nil,
  Img_Background = nil,
  Group_ForgeList = {
    self = nil,
    ScrollGrid_Forge = {
      self = nil,
      grid = {
        self = nil,
        Img_Bg = nil,
        Group_Item = {
          self = nil,
          Btn_Item = nil,
          Img_Bottom01 = nil,
          Img_Bottom02 = nil,
          Img_Bottom03 = nil,
          Img_Bottom04 = nil,
          Img_Bottom05 = nil,
          Img_Item = nil,
          Txt_Num = nil,
          Img_Type = nil
        },
        Txt_Name = nil,
        Btn_Item = nil
      }
    }
  },
  Group_Screen = {
    self = nil,
    Btn_Screen = {
      self = nil,
      Group_On = {
        self = nil,
        Img_Bg = nil,
        Img_On = nil,
        Img_Screen = {self = nil, Txt_Screen = nil}
      },
      Group_Off = {
        self = nil,
        Img_Bg = nil,
        Img_Off = nil,
        Img_Screen = {self = nil, Txt_Screen = nil}
      }
    },
    Group_ScreenList = {
      self = nil,
      Img_Bg = nil,
      Btn_Mask = nil,
      StaticGrid_ScreenList = {
        self = nil,
        grid = {
          self = nil,
          Btn_Item = {self = nil, Txt_Item = nil},
          Img_Item = {self = nil, Txt_Item = nil}
        }
      }
    }
  },
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = {self = nil, Txt_Return = nil},
    Btn_Home = {self = nil, Txt_Home = nil},
    Btn_Help = nil
  },
  Group_Right = {
    self = nil,
    Group_Target = {
      self = nil,
      Group_Item = {
        self = nil,
        Btn_Item = nil,
        Img_Bottom01 = nil,
        Img_Bottom02 = nil,
        Img_Bottom03 = nil,
        Img_Bottom04 = nil,
        Img_Bottom05 = nil,
        Img_Item = nil,
        Txt_Num = nil,
        Img_Type = nil
      }
    },
    Group_Material = {
      self = nil,
      StaticGrid_Material = {
        self = nil,
        grid = {
          self = nil,
          Group_Item02 = {
            self = nil,
            Img_NeedBottom = nil,
            Txt_Need = nil,
            Txt_And = nil,
            Txt_Have = nil,
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil
            }
          }
        }
      },
      Txt_Title = nil
    },
    Btn_Forge = {self = nil, Txt_Name = nil}
  }
}
return EquipForge
