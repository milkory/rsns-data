local Enemy_Detail = {
  self = nil,
  Btn_BG = {self = nil, Img_BG = nil},
  Group_Back = {
    self = nil,
    Img_BG = nil,
    Img_Back = nil,
    Txt_Title = nil
  },
  Group_Enemy = {self = nil, Img_Enemy = nil},
  Img_Mask = nil,
  Group_Left = {
    self = nil,
    Group_TopLeft = {
      self = nil,
      Img_Decoration = nil,
      Img_TypeIcon = nil,
      Txt_SideName = nil,
      Txt_TypeName = nil
    },
    Img_IconSide = nil,
    Group_BottomLeft = {
      self = nil,
      Group_Ver1 = {
        self = nil,
        Img_Back = nil,
        Group_HP = {
          self = nil,
          Txt_HP = nil,
          Txt_Num = nil
        },
        Group_DEF = {
          self = nil,
          Txt_DEF = nil,
          Txt_Num = nil
        },
        Group_ATK = {
          self = nil,
          Txt_ATK = nil,
          Txt_Num = nil
        }
      },
      Group_Ver2 = {
        self = nil,
        Group_HP = {
          self = nil,
          Txt_HP = nil,
          Txt_Num = nil
        },
        Group_DEF = {
          self = nil,
          Txt_DEF = nil,
          Txt_Num = nil
        },
        Group_ATK = {
          self = nil,
          Txt_ATK = nil,
          Txt_Num = nil
        }
      }
    },
    Group_BottomRight = {
      self = nil,
      Img_Decoration = nil,
      Txt_ = nil
    }
  },
  ScrollView_Right = {
    self = nil,
    Viewport = {
      self = nil,
      Content = {
        self = nil,
        Group_Icon = {
          self = nil,
          Group_Identity = {
            self = nil,
            Img_BG = nil,
            Img_IdentityIcon = nil,
            Txt_Identity = nil,
            ScrollGrid_Identity = {
              self = nil,
              grid = {
                self = nil,
                Img_TagIcon = nil,
                Txt_TagName = nil
              }
            },
            Txt_None = nil
          },
          Group_Resistance = {
            self = nil,
            Img_BG = nil,
            Img_ResistanceIcon = nil,
            Txt_Resistance = nil,
            ScrollGrid_Resistance = {
              self = nil,
              grid = {
                self = nil,
                Img_TagIcon = nil,
                Txt_TagName = nil
              }
            },
            Txt_None = nil
          },
          Group_Weakness = {
            self = nil,
            Img_BG = nil,
            Img_Weakness = nil,
            Txt_Weakness = nil,
            ScrollGrid_Weakness = {
              self = nil,
              grid = {
                self = nil,
                Img_TagIcon = nil,
                Txt_TagName = nil
              }
            },
            Txt_None = nil
          }
        },
        Group_Drop = {
          self = nil,
          Group_Title = {
            self = nil,
            Img_Icon = nil,
            Txt_Title = nil
          },
          StaticGrid_DropItem = {
            self = nil,
            grid = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Img_Mask = nil
            }
          }
        },
        Group_Description = {self = nil, Txt_Content = nil}
      }
    }
  }
}
return Enemy_Detail
