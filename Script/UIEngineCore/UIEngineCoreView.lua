local EngineCore = {
  self = nil,
  Img_BG = nil,
  Group_Engine = {
    self = nil,
    Img_Di = nil,
    Img_Gear = nil,
    Group_Core = {
      self = nil,
      Group_Ice = {
        self = nil,
        Img_Core = nil,
        Img_Limit = nil
      },
      Group_Electric = {
        self = nil,
        Img_Core = nil,
        Img_Limit = nil
      },
      Group_Fire = {
        self = nil,
        Img_Core = nil,
        Img_Limit = nil
      },
      Group_Negative = {
        self = nil,
        Img_Core = nil,
        Img_Limit = nil
      },
      Group_Reverberation = {
        self = nil,
        Img_Core = nil,
        Img_Limit = nil
      }
    },
    Img_Select = nil,
    Drag_Panel = nil
  },
  Group_Now = {
    self = nil,
    Txt_ = nil,
    Txt_Record = nil,
    Group_Check = {
      self = nil,
      Img_ = nil,
      Img_ = nil,
      Txt_ = nil,
      Btn_ = nil,
      Img_RedPoint = nil
    },
    Img_Icon = nil,
    Txt_EngName = nil,
    Txt_Name = nil,
    Group_BreakShow = {
      self = nil,
      Txt_Num = nil,
      Img_ = nil,
      Img_Break1 = nil,
      Img_Break2 = nil,
      Img_Break3 = nil,
      Img_Break4 = nil,
      Img_Break5 = nil
    },
    Img_ = nil,
    Img_ = nil,
    Img_Di = nil,
    Txt_ = nil,
    Group_Upgrade = {
      self = nil,
      Group_Monster = {
        self = nil,
        Img_1 = nil,
        Img_Mask = {self = nil, Img_Icon = nil}
      },
      Img_ = nil,
      ScrollView_Describe = {
        self = nil,
        Viewport = {self = nil, Txt_Describe = nil}
      },
      Txt_Name = nil,
      Txt_ = nil,
      Txt_Dec = nil,
      Btn_Challenge = {self = nil, Txt_ = nil},
      Txt_Condition = nil,
      StaticGrid_List = {self = nil, Txt_Condition = nil},
      Group_Max = {
        self = nil,
        Txt_ = nil,
        Txt_ = nil
      }
    },
    Group_Break = {
      self = nil,
      Txt_ = nil,
      Txt_ = nil,
      Txt_ = nil,
      Txt_ = nil,
      Img_ = nil,
      Txt_Before = nil,
      Txt_Next = nil,
      Txt_ = nil,
      Btn_Break = {self = nil, Txt_ = nil},
      Group_Need = {
        self = nil,
        Img_ = nil,
        Img_ = nil,
        Img_ = nil,
        Group_Item = {
          self = nil,
          Group_Consume1 = {
            self = nil,
            Img_NeedBottom = nil,
            Group_Cost = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            },
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil,
              Img_Mask = nil,
              Group_EType = {
                self = nil,
                Img_IconBg = nil,
                Img_Icon = nil
              }
            },
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            }
          },
          Group_Consume2 = {
            self = nil,
            Img_NeedBottom = nil,
            Group_Cost = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            },
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil,
              Img_Mask = nil,
              Group_EType = {
                self = nil,
                Img_IconBg = nil,
                Img_Icon = nil
              }
            },
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            }
          },
          Group_Consume3 = {
            self = nil,
            Img_NeedBottom = nil,
            Group_Cost = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            },
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil,
              Img_Mask = nil,
              Group_EType = {
                self = nil,
                Img_IconBg = nil,
                Img_Icon = nil
              }
            },
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            }
          }
        }
      }
    },
    Group_Limit = {
      self = nil,
      Group_Monster = {
        self = nil,
        Img_1 = nil,
        Img_Mask = {self = nil, Img_Icon = nil}
      },
      Btn_Challenge = {self = nil, Txt_ = nil},
      Img_ = nil,
      Txt_Name = nil,
      Txt_ = nil,
      Img_ = nil,
      Img_ = nil,
      Img_ = nil,
      Img_ = nil,
      Img_ = nil,
      Txt_Grade = nil
    }
  },
  Group_Next = {
    self = nil,
    Txt_ = nil,
    Txt_Record = nil,
    Img_Icon = nil,
    Group_Check = {
      self = nil,
      Img_ = nil,
      Img_ = nil,
      Txt_ = nil,
      Btn_ = nil,
      Img_RedPoint = nil
    },
    Txt_EngName = nil,
    Txt_Name = nil,
    Group_BreakShow = {
      self = nil,
      Txt_Num = nil,
      Img_ = nil,
      Img_Break1 = nil,
      Img_Break2 = nil,
      Img_Break3 = nil,
      Img_Break4 = nil,
      Img_Break5 = nil
    },
    Img_ = nil,
    Img_ = nil,
    Img_Di = nil,
    Txt_ = nil,
    Group_Upgrade = {
      self = nil,
      Group_Monster = {
        self = nil,
        Img_1 = nil,
        Img_Mask = {self = nil, Img_Icon = nil}
      },
      Img_ = nil,
      ScrollView_Describe = {
        self = nil,
        Viewport = {self = nil, Txt_Describe = nil}
      },
      Txt_Name = nil,
      Txt_ = nil,
      Txt_Dec = nil,
      Btn_Challenge = {self = nil, Txt_ = nil},
      Txt_Condition = nil,
      StaticGrid_List = {self = nil, Txt_Condition = nil},
      Group_Max = {
        self = nil,
        Txt_ = nil,
        Txt_ = nil
      }
    },
    Group_Break = {
      self = nil,
      Txt_ = nil,
      Txt_ = nil,
      Txt_ = nil,
      Txt_ = nil,
      Img_ = nil,
      Txt_Before = nil,
      Txt_Next = nil,
      Txt_ = nil,
      Btn_Break = {self = nil, Txt_ = nil},
      Group_Need = {
        self = nil,
        Img_ = nil,
        Img_ = nil,
        Img_ = nil,
        Group_Item = {
          self = nil,
          Group_Consume1 = {
            self = nil,
            Img_NeedBottom = nil,
            Group_Cost = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            },
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil,
              Img_Mask = nil,
              Group_EType = {
                self = nil,
                Img_IconBg = nil,
                Img_Icon = nil
              }
            },
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            }
          },
          Group_Consume2 = {
            self = nil,
            Img_NeedBottom = nil,
            Group_Cost = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            },
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil,
              Img_Mask = nil,
              Group_EType = {
                self = nil,
                Img_IconBg = nil,
                Img_Icon = nil
              }
            },
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            }
          },
          Group_Consume3 = {
            self = nil,
            Img_NeedBottom = nil,
            Group_Cost = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            },
            Group_Item = {
              self = nil,
              Btn_Item = nil,
              Img_Bottom = nil,
              Img_Item = nil,
              Txt_Num = nil,
              Img_Mask = nil,
              Group_EType = {
                self = nil,
                Img_IconBg = nil,
                Img_Icon = nil
              }
            },
            Group_Break = {
              self = nil,
              Img_Mask = {self = nil, Img_Face = nil},
              Img_F = nil
            }
          }
        }
      }
    },
    Group_Limit = {
      self = nil,
      Group_Monster = {
        self = nil,
        Img_1 = nil,
        Img_Mask = {self = nil, Img_Icon = nil}
      },
      Btn_Challenge = {self = nil, Txt_ = nil},
      Img_ = nil,
      Txt_Name = nil,
      Txt_ = nil,
      Img_ = nil,
      Img_ = nil,
      Img_ = nil,
      Img_ = nil,
      Img_ = nil,
      Txt_Grade = nil
    }
  },
  Img_Effect = nil,
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
  },
  Group_Tips = {
    self = nil,
    Img_Tips = nil,
    Txt_Tips = nil
  },
  Img_EffectBg = nil
}
return EngineCore
