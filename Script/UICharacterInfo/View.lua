local View = {
  self = nil,
  Group_Middle = {
    self = nil,
    Sprite_Background = nil,
    Sprite_Group = nil,
    Img_Character = nil,
    Spine_Character = nil
  },
  Group_TabInfo = {
    self = nil,
    Group_TIBottomLeft = {
      self = nil,
      Img_LevelBottom = {
        self = nil,
        Txt_LV = nil,
        Txt_LVNum = {
          self = nil,
          Txt_LVAnd = {self = nil, Txt_LVCap = nil}
        },
        Img_EXPPBBottom = nil,
        Img_EXPPB = nil,
        Btn_LevelUp = nil,
        Txt_EXP = nil,
        Txt_EXPNum = nil
      },
      Btn_Attribute = {
        self = nil,
        Img_Attack = {self = nil, Txt_Attack = nil},
        Img_Health = {self = nil, Txt_Health = nil},
        Img_Defense = {self = nil, Txt_Defense = nil},
        Img_All = nil
      },
      Img_FriendlinessBottom = {
        self = nil,
        Txt_Friendliness = nil,
        Txt_LV = nil,
        Txt_LVNum = nil,
        Txt_EXPNum = nil
      },
      Btn_Skin = nil,
      Btn_Information = nil,
      Btn_Show = nil
    },
    Group_TIRight = {
      self = nil,
      Group_TITop = {
        self = nil,
        Txt_NameCH = nil,
        Txt_NameEN = nil,
        Img_Star01 = nil,
        Img_Star02 = nil,
        Img_Star03 = nil,
        Img_Star04 = nil,
        Img_Star05 = nil,
        Img_Career = nil,
        Img_TagBottom = nil,
        Img_Tag01 = nil,
        Img_Tag02 = nil,
        Img_Tag03 = nil,
        Img_BKBottom = {
          self = nil,
          Img_BK01 = nil,
          Img_BK02 = nil,
          Img_BK03 = nil,
          Img_BK04 = nil,
          Img_BK05 = nil,
          Txt_BK = nil,
          Txt_BKLevel = nil,
          Txt_AttNull = nil,
          Group_OneAtt = {self = nil, Txt_Att01 = nil},
          Group_TwoAtt = {
            self = nil,
            Txt_Att01 = nil,
            Txt_Att02 = nil
          }
        }
      },
      Group_TIMiddle = {
        self = nil,
        Img_SkillBottom = nil,
        Txt_SkillCH = nil,
        Txt_SkillEN = nil,
        Btn_Skill01 = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil,
          Txt_SkillLV = {self = nil, Txt_Num = nil}
        },
        Btn_Skill02 = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil,
          Txt_SkillLV = {self = nil, Txt_Num = nil}
        },
        Btn_Skill03 = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil,
          Txt_SkillLV = {self = nil, Txt_Num = nil}
        },
        Btn_LvUp = {self = nil, Txt_LvUp = nil}
      },
      Group_TIBottom = {
        self = nil,
        Img_EquipmentBottom = nil,
        Txt_EquipmentCH = nil,
        Txt_EquipmentEN = nil,
        Btn_Equipment01 = {
          self = nil,
          Btn_Item = nil,
          Img_Bottom01 = nil,
          Img_Bottom02 = nil,
          Img_Bottom03 = nil,
          Img_Bottom04 = nil,
          Img_Bottom05 = nil,
          Img_Item = nil,
          Txt_Num = nil,
          Img_Equipping = {self = nil, Txt_Equipping = nil},
          Img_Type = nil,
          Img_nullBG = nil
        },
        Btn_Equipment02 = {
          self = nil,
          Btn_Item = nil,
          Img_Bottom01 = nil,
          Img_Bottom02 = nil,
          Img_Bottom03 = nil,
          Img_Bottom04 = nil,
          Img_Bottom05 = nil,
          Img_Item = nil,
          Txt_Num = nil,
          Img_Equipping = {self = nil, Txt_Equipping = nil},
          Img_Type = nil,
          Img_nullBG = nil
        },
        Btn_Equipment03 = {
          self = nil,
          Btn_Item = nil,
          Img_Bottom01 = nil,
          Img_Bottom02 = nil,
          Img_Bottom03 = nil,
          Img_Bottom04 = nil,
          Img_Bottom05 = nil,
          Img_Item = nil,
          Txt_Num = nil,
          Img_Equipping = {self = nil, Txt_Equipping = nil},
          Img_Type = nil,
          Img_nullBG = nil
        }
      }
    }
  },
  Group_TabAwake = {
    self = nil,
    Group_TARight = {
      self = nil,
      Img_TABottom = nil,
      Group_TATop = {
        self = nil,
        Img_Level01 = nil,
        Img_Level02 = nil,
        Img_Level03 = nil,
        Img_Level04 = nil,
        Img_Level05 = nil,
        Img_Awake = nil
      },
      Group_TAMiddle = {
        self = nil,
        Img_Info = nil,
        Txt_Info = nil,
        Btn_Detail = {self = nil, Txt_Name = nil}
      },
      Group_TABottom = {
        self = nil,
        Img_Bottom = nil,
        Btn_Awake = nil,
        Group_Level = {
          self = nil,
          Img_Level = nil,
          Txt_LV = nil,
          Txt_LVNum = nil,
          Group_NeedLv = {
            self = nil,
            Img_NeedBottom = nil,
            Txt_Need = nil,
            Txt_And = nil,
            Txt_Have = nil
          }
        },
        ScrollGrid_Item = {
          self = nil,
          grid = {
            {
              self = nil,
              Group_Container = {
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
          }
        }
      }
    }
  },
  Group_TabBreakThrough = {
    self = nil,
    Group_TBRight = {
      self = nil,
      Img_TBBottom = nil,
      Group_TBTop = {
        self = nil,
        Img_BKBottom = nil,
        Img_BK01 = nil,
        Img_BK02 = nil,
        Img_BK03 = nil,
        Img_BK04 = nil,
        Img_BK05 = nil
      },
      Group_TBMiddle = {
        self = nil,
        Img_Info = nil,
        Group_Text = {
          self = nil,
          Txt_Off = nil,
          Txt_On = nil
        },
        ScrollGrid_Stage = {
          self = nil,
          grid = {
            {
              self = nil,
              Txt_Off = nil,
              Txt_On = nil
            }
          }
        },
        Txt_Level = nil,
        Txt_AttNull = nil,
        TowAtt = {
          self = nil,
          Txt_Att01 = nil,
          Txt_Att02 = nil
        }
      },
      Group_TBBottom = {
        self = nil,
        Img_Bottom = nil,
        Btn_BK = nil,
        ScrollGrid_Item = {
          self = nil,
          grid = {
            {
              self = nil,
              Group_Container = {
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
          }
        }
      }
    }
  },
  Group_TabTalent = {
    self = nil,
    Group_TTRight = {
      self = nil,
      ScrollGrid_Awaka = {
        self = nil,
        grid = {
          {
            self = nil,
            Txt_Level = nil,
            Txt_Tips = nil,
            Img_Skill = {self = nil, Img_Lock = nil}
          }
        }
      }
    }
  },
  Group_TabSkill = {
    self = nil,
    Img_Black = nil,
    ScrollGrid_SkillList = {
      self = nil,
      grid = {
        {
          self = nil,
          Group_Off = {self = nil, Img_Bg_off = nil},
          Group_On = {self = nil, Img_Bg_on = nil},
          Img_Icon = nil,
          Txt_Name = nil,
          Txt_Lv = nil,
          Txt_Desc = nil
        }
      }
    },
    Group_Level = {
      self = nil,
      Img_Level = nil,
      Txt_LV = nil,
      Txt_LVNum = nil,
      Group_NeedLv = {
        self = nil,
        Img_NeedBottom = nil,
        Txt_Need = nil,
        Txt_And = nil,
        Txt_Have = nil
      }
    },
    ScrollGrid_Item = {
      self = nil,
      grid = {
        {
          self = nil,
          Group_Container = {
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
      }
    },
    Btn_Lvup = {self = nil, Txt_Name = nil}
  },
  Group_TabResonance = {
    self = nil,
    Group_TARight = {
      self = nil,
      Img_TABottom = nil,
      Group_TATop = {
        self = nil,
        Img_Level00 = nil,
        Img_Level01 = nil,
        Img_Level02 = nil,
        Img_Level03 = nil,
        Img_Awake = nil,
        Img_LevelBottom = {
          self = nil,
          Group_LV = {
            self = nil,
            Txt_LV = {self = nil, Txt_LVAnd = nil},
            Txt_LVNum = nil,
            Txt_LVCap = nil
          },
          Img_EXPPBBottom = nil,
          Img_EXPPB = nil,
          Txt_EXP = nil,
          Group_EXP = {self = nil, Txt_EXPNum = nil}
        }
      },
      Group_TAMiddle = {
        self = nil,
        Img_Info = nil,
        Txt_Info = nil,
        Btn_Detail = {self = nil, Txt_Name = nil}
      },
      Group_TABottom = {
        self = nil,
        Img_Bottom = nil,
        Btn_Resonance = {self = nil, Txt_ = nil},
        ScrollGrid_Item = {
          self = nil,
          grid = {
            {
              self = nil,
              Group_Container = {
                self = nil,
                Img_NeedBottom = nil,
                Txt_Have = nil,
                Group_Item = {
                  self = nil,
                  Btn_Item = nil,
                  Img_Bottom = nil,
                  Img_Item = nil,
                  Txt_Num = nil
                }
              },
              Img_Add = nil
            }
          }
        }
      }
    }
  },
  Group_TopLeft = {
    self = nil,
    Group_CommonTopLeft = {
      self = nil,
      Btn_Return = nil,
      Btn_Home = nil,
      Btn_Help = nil
    }
  },
  Group_TopRight = {
    self = nil,
    Btn_TabInfo = {
      self = nil,
      Img_N = nil,
      Img_P = nil
    },
    Btn_TabAwake = {
      self = nil,
      Img_N = nil,
      Img_P = nil
    },
    Btn_TabBreakThrough = {
      self = nil,
      Img_N = nil,
      Img_P = nil
    },
    Btn_TabResonance = {
      self = nil,
      Img_N = nil,
      Img_P = nil
    },
    Btn_TabTalent = {
      self = nil,
      Img_N = nil,
      Img_P = nil
    }
  }
}
return View
