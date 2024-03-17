local viewModel = {
  Group_Middle = {
    self = _self,
    Sprite_Background = Sprite_Background,
    Sprite_Group = Sprite_Group,
    Img_Character = Img_Character,
    Spine_Character = Spine_Character
  },
  Group_TabInfo = {
    self = _self,
    Group_TIBottomLeft = {
      self = _self,
      Img_LevelBottom = {
        self = _self,
        Txt_LV = Txt_LV,
        Txt_LVNum = {
          self = _self,
          Txt_LVAnd = {
            self = _self,
            Txt_LVCap = Txt_LVCap
          }
        },
        Img_EXPPBBottom = Img_EXPPBBottom,
        Img_EXPPB = Img_EXPPB,
        Btn_LevelUp = Btn_LevelUp,
        Txt_EXP = Txt_EXP,
        Txt_EXPNum = Txt_EXPNum
      },
      Btn_Attribute = {
        self = _self,
        Img_Attack = {
          self = _self,
          Txt_Attack = Txt_Attack
        },
        Img_Health = {
          self = _self,
          Txt_Health = Txt_Health
        },
        Img_Defense = {
          self = _self,
          Txt_Defense = Txt_Defense
        },
        Img_All = Img_All
      },
      Img_FriendlinessBottom = {
        self = _self,
        Txt_Friendliness = Txt_Friendliness,
        Txt_LV = Txt_LV,
        Txt_LVNum = Txt_LVNum,
        Txt_EXPNum = Txt_EXPNum
      },
      Btn_Skin = Btn_Skin,
      Btn_Information = Btn_Information,
      Btn_Show = Btn_Show
    },
    Group_TIRight = {
      self = _self,
      Group_TITop = {
        self = _self,
        Txt_NameCH = Txt_NameCH,
        Txt_NameEN = Txt_NameEN,
        Img_Star01 = Img_Star01,
        Img_Star02 = Img_Star02,
        Img_Star03 = Img_Star03,
        Img_Star04 = Img_Star04,
        Img_Star05 = Img_Star05,
        Img_Career = Img_Career,
        Img_TagBottom = Img_TagBottom,
        Img_Tag01 = Img_Tag01,
        Img_Tag02 = Img_Tag02,
        Img_Tag03 = Img_Tag03,
        Img_BKBottom = {
          self = _self,
          Img_BK01 = Img_BK01,
          Img_BK02 = Img_BK02,
          Img_BK03 = Img_BK03,
          Img_BK04 = Img_BK04,
          Img_BK05 = Img_BK05,
          Txt_BK = Txt_BK,
          Txt_BKLevel = Txt_BKLevel,
          Txt_AttNull = Txt_AttNull,
          Group_OneAtt = {
            self = _self,
            Txt_Att01 = Txt_Att01
          },
          Group_TwoAtt = {
            self = _self,
            Txt_Att01 = Txt_Att01,
            Txt_Att02 = Txt_Att02
          }
        }
      },
      Group_TIMiddle = {
        self = _self,
        Img_SkillBottom = Img_SkillBottom,
        Txt_SkillCH = Txt_SkillCH,
        Txt_SkillEN = Txt_SkillEN,
        Btn_Skill01 = {
          self = _self,
          Img_Icon = Img_Icon,
          Txt_Name = Txt_Name,
          Txt_SkillLV = {
            self = _self,
            Txt_Num = Txt_Num
          }
        },
        Btn_Skill02 = {
          self = _self,
          Img_Icon = Img_Icon,
          Txt_Name = Txt_Name,
          Txt_SkillLV = {
            self = _self,
            Txt_Num = Txt_Num
          }
        },
        Btn_Skill03 = {
          self = _self,
          Img_Icon = Img_Icon,
          Txt_Name = Txt_Name,
          Txt_SkillLV = {
            self = _self,
            Txt_Num = Txt_Num
          }
        }
      },
      Group_TIBottom = {
        self = _self,
        Img_EquipmentBottom = Img_EquipmentBottom,
        Txt_EquipmentCH = Txt_EquipmentCH,
        Txt_EquipmentEN = Txt_EquipmentEN,
        Btn_Equipment01 = {
          self = _self,
          Btn_Item = Btn_Item,
          Img_Bottom01 = Img_Bottom01,
          Img_Bottom02 = Img_Bottom02,
          Img_Bottom03 = Img_Bottom03,
          Img_Bottom04 = Img_Bottom04,
          Img_Bottom05 = Img_Bottom05,
          Img_Item = Img_Item,
          Txt_Num = Txt_Num,
          Img_nullBG = Img_nullBG
        },
        Btn_Equipment02 = {
          self = _self,
          Btn_Item = Btn_Item,
          Img_Bottom01 = Img_Bottom01,
          Img_Bottom02 = Img_Bottom02,
          Img_Bottom03 = Img_Bottom03,
          Img_Bottom04 = Img_Bottom04,
          Img_Bottom05 = Img_Bottom05,
          Img_Item = Img_Item,
          Txt_Num = Txt_Num,
          Img_nullBG = Img_nullBG
        },
        Btn_Equipment03 = {
          self = _self,
          Btn_Item = Btn_Item,
          Img_Bottom01 = Img_Bottom01,
          Img_Bottom02 = Img_Bottom02,
          Img_Bottom03 = Img_Bottom03,
          Img_Bottom04 = Img_Bottom04,
          Img_Bottom05 = Img_Bottom05,
          Img_Item = Img_Item,
          Txt_Num = Txt_Num,
          Img_nullBG = Img_nullBG
        }
      }
    }
  },
  Group_TabAwake = {
    self = _self,
    Group_TARight = {
      self = _self,
      Img_TABottom = {
        self = _self,
        Group_TATop = {
          self = _self,
          Img_Level01 = Img_Level01,
          Img_Level02 = Img_Level02,
          Img_Level03 = Img_Level03,
          Img_Level04 = Img_Level04,
          Img_Level05 = Img_Level05,
          Img_Awake = Img_Awake
        },
        Group_TAMiddle = {
          self = _self,
          Img_Info = {
            self = _self,
            Txt_Info = Txt_Info
          }
        },
        Group_TABottom = {
          self = _self,
          Img_Bottom = Img_Bottom,
          Btn_Awake = Btn_Awake,
          Img_Level = {
            self = _self,
            Txt_LV = Txt_LV,
            Txt_LVNum = Txt_LVNum,
            Img_NeedBottom = {
              self = _self,
              Txt_Need = Txt_Need,
              Txt_And = Txt_And,
              Txt_Have = Txt_Have
            }
          },
          Img_Item01 = {
            self = _self,
            Img_NeedBottom = {
              self = _self,
              Txt_Need = Txt_Need,
              Txt_And = Txt_And,
              Txt_Have = Txt_Have
            },
            Group_Item = {
              self = _self,
              Btn_Item = Btn_Item,
              Img_Bottom01 = Img_Bottom01,
              Img_Bottom02 = Img_Bottom02,
              Img_Bottom03 = Img_Bottom03,
              Img_Bottom04 = Img_Bottom04,
              Img_Bottom05 = Img_Bottom05,
              Img_Item = Img_Item,
              Txt_Num = Txt_Num
            }
          },
          Img_Item02 = {
            self = _self,
            Img_NeedBottom = {
              self = _self,
              Txt_Need = Txt_Need,
              Txt_And = Txt_And,
              Txt_Have = Txt_Have
            },
            Group_Item = {
              self = _self,
              Btn_Item = Btn_Item,
              Img_Bottom01 = Img_Bottom01,
              Img_Bottom02 = Img_Bottom02,
              Img_Bottom03 = Img_Bottom03,
              Img_Bottom04 = Img_Bottom04,
              Img_Bottom05 = Img_Bottom05,
              Img_Item = Img_Item,
              Txt_Num = Txt_Num
            }
          },
          Img_Item03 = {
            self = _self,
            Img_NeedBottom = {
              self = _self,
              Txt_Need = Txt_Need,
              Txt_And = Txt_And,
              Txt_Have = Txt_Have
            },
            Group_Item = {
              self = _self,
              Btn_Item = Btn_Item,
              Img_Bottom01 = Img_Bottom01,
              Img_Bottom02 = Img_Bottom02,
              Img_Bottom03 = Img_Bottom03,
              Img_Bottom04 = Img_Bottom04,
              Img_Bottom05 = Img_Bottom05,
              Img_Item = Img_Item,
              Txt_Num = Txt_Num
            }
          }
        }
      }
    }
  },
  Group_TabBreakThrough = {
    self = _self,
    Group_TBRight = {
      self = _self,
      Img_TBBottom = {
        self = _self,
        Group_TBTop = {
          self = _self,
          Img_BKBottom = Img_BKBottom,
          Img_BK01 = Img_BK01,
          Img_BK02 = Img_BK02,
          Img_BK03 = Img_BK03,
          Img_BK04 = Img_BK04,
          Img_BK05 = Img_BK05
        },
        Group_TBMiddle = {
          self = _self,
          Img_Info = {
            self = _self,
            Txt_Level = Txt_Level,
            Txt_AttNull = Txt_AttNull,
            OneAtt = {
              self = _self,
              Txt_Att01 = Txt_Att01
            },
            TowAtt = {
              self = _self,
              Txt_Att01 = Txt_Att01,
              Txt_Att02 = Txt_Att02
            }
          }
        },
        Group_TBBottom = {
          self = _self,
          Img_Bottom = Img_Bottom,
          Btn_BK = Btn_BK,
          Img_Item01 = {
            self = _self,
            Img_NeedBottom = {
              self = _self,
              Txt_Need = Txt_Need,
              Txt_And = Txt_And,
              Txt_Have = Txt_Have
            },
            Group_Item = {
              self = _self,
              Btn_Item = Btn_Item,
              Img_Bottom01 = Img_Bottom01,
              Img_Bottom02 = Img_Bottom02,
              Img_Bottom03 = Img_Bottom03,
              Img_Bottom04 = Img_Bottom04,
              Img_Bottom05 = Img_Bottom05,
              Img_Item = Img_Item,
              Txt_Num = Txt_Num
            }
          },
          Img_Item02 = {
            self = _self,
            Img_NeedBottom = {
              self = _self,
              Txt_Have = Txt_Have,
              Txt_And = Txt_And,
              Txt_Need = Txt_Need
            },
            Group_Item = {
              self = _self,
              Btn_Item = Btn_Item,
              Img_Bottom01 = Img_Bottom01,
              Img_Bottom02 = Img_Bottom02,
              Img_Bottom03 = Img_Bottom03,
              Img_Bottom04 = Img_Bottom04,
              Img_Bottom05 = Img_Bottom05,
              Img_Item = Img_Item,
              Txt_Num = Txt_Num
            }
          }
        }
      }
    }
  },
  Group_TabSkill = {
    self = _self
  },
  Group_TabTalent = {
    self = _self,
    Group_TTRight = {
      self = _self,
      Img_Awake01 = {
        self = _self,
        Txt_Level = Txt_Level,
        Txt_Tips01 = Txt_Tips01,
        Img_Skill01 = {
          self = _self,
          Img_Lock = Img_Lock
        }
      },
      Img_Awake02 = {
        self = _self,
        Txt_Level = Txt_Level,
        Txt_Tips02 = Txt_Tips02,
        Img_Skill02 = {
          self = _self,
          Img_Lock = Img_Lock
        }
      },
      Img_Awake03 = {
        self = _self,
        Txt_Level = Txt_Level,
        Txt_Tips03 = Txt_Tips03,
        Img_Skill03 = {
          self = _self,
          Img_Lock = Img_Lock
        }
      },
      Img_Awake04 = {
        self = _self,
        Txt_Level = Txt_Level,
        Txt_Tips04 = Txt_Tips04,
        Img_Skill04 = {
          self = _self,
          Img_Lock = Img_Lock
        },
        Img_Skill05 = {
          self = _self,
          Img_Lock = Img_Lock
        },
        Img_Skill06 = {
          self = _self,
          Img_Lock = Img_Lock
        }
      }
    }
  },
  Group_TopLeft = {
    self = _self,
    Group_CommonTopLeft = {
      self = _self,
      Btn_Return = Btn_Return,
      Btn_Home = Btn_Home,
      Btn_Help = Btn_Help
    }
  },
  Group_TopRight = {
    self = _self,
    Btn_TabInfo = {
      self = _self,
      Img_N = Img_N,
      Img_P = Img_P
    },
    Btn_TabAwake = {
      self = _self,
      Img_N = Img_N,
      Img_P = Img_P
    },
    Btn_TabBreakThrough = {
      self = _self,
      Img_N = Img_N,
      Img_P = Img_P
    },
    Btn_TabSkill = {
      self = _self,
      Img_N = Img_N,
      Img_P = Img_P
    },
    Btn_TabTalent = {
      self = _self,
      Img_N = Img_N,
      Img_P = Img_P
    }
  }
}
return viewModel
