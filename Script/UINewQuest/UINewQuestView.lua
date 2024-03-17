local NewQuest = {
  self = nil,
  Img_BG = nil,
  Img_ZC = {
    self = nil,
    Img_ = nil,
    Btn_Effect = {self = nil, Txt_ = nil},
    Btn_NotEffect = {self = nil, Txt_ = nil},
    ScrollGrid_WeekSwitch = {
      self = nil,
      grid = {
        self = nil,
        Img_BG = nil,
        Img_Select = nil,
        Txt_Week = nil,
        Txt_SuccessNum = nil,
        Txt_SelectWeek = nil,
        Txt_SelectSuccessNum = nil,
        Img_Effect = nil,
        Img_SelectNotPass = nil,
        Btn_S = nil,
        Img_NotPass = nil
      }
    }
  },
  Group_Main = {
    self = nil,
    Group_BattlePassGrade = {
      self = nil,
      Img_ = nil,
      Txt_ = nil,
      Txt_Level = nil,
      Img_Grade = nil,
      Img_NowGrade = nil,
      Txt_NowGrade = nil,
      Txt_Grade = nil,
      Txt_A = nil,
      Btn_BattlePass = {self = nil, Txt_ = nil},
      Img_T = nil,
      Txt_C = nil,
      Group_BattlePassBox = {
        self = nil,
        Img_ = nil,
        Btn_OpenBox = nil,
        Btn_CloseBox = nil
      }
    },
    Group_DailyBox = {
      self = nil,
      Img_BG = nil,
      Txt_QuestNum = nil,
      Txt_c = nil,
      Txt_ = nil,
      Img_Grade = nil,
      Img_NowGrade = nil,
      Btn_Box = {
        self = nil,
        Group_CanGet = {
          self = nil,
          Img_BG1 = nil,
          Img_Effect = nil,
          Img_Box = nil
        },
        Group_UnGet = {
          self = nil,
          Img_BG = nil,
          Img_Box = nil
        },
        Group_NotGet = {
          self = nil,
          Img_BG = nil,
          Img_Box = nil,
          Img_T = {self = nil, Txt_ = nil}
        }
      }
    },
    Group_Calendar = {
      self = nil,
      Img_ = nil,
      Img_A = nil,
      Txt_Day = nil,
      Img_B = nil,
      Group_Month = {
        self = nil,
        Txt_Jan = nil,
        Txt_Feb = nil,
        Txt_Mar = nil,
        Txt_Apr = nil,
        Txt_May = nil,
        Txt_Jun = nil,
        Txt_Jul = nil,
        Txt_Aug = nil,
        Txt_Sept = nil,
        Txt_Oct = nil,
        Txt_Nov = nil,
        Txt_Dec = nil
      },
      Group_Date = {
        self = nil,
        Txt_X = nil,
        Txt_J = nil,
        Txt_B = nil,
        Img_X = nil,
        Img_J = nil,
        Img_B = nil
      }
    },
    Group_CommonTopLeft = {
      self = nil,
      Btn_Return = {self = nil, Txt_Return = nil},
      Btn_Home = {self = nil, Txt_Home = nil},
      Btn_Help = nil
    },
    Group_BottomBar = {
      self = nil,
      Img_BG = nil,
      Img_BG1 = nil,
      Group_QuestSwitch = {
        self = nil,
        Img_CheckDailyQuest = {
          self = nil,
          Txt_DailyQuest = nil,
          Txt_TS = nil
        },
        Txt_DailyQuest = nil,
        Txt_WeekQuest = nil,
        Img_CheckWeekQuest = {
          self = nil,
          Txt_WeekQuest = nil,
          Txt_TS = nil
        }
      },
      Txt_DailySuccessNum = nil,
      Btn_Get = {self = nil, Txt_ = nil},
      Txt_WeekSuccessNum = nil,
      Btn_Day = nil,
      Btn_Week = nil
    },
    Group_Shop = {
      self = nil,
      Img_BG = nil,
      Img_Shop = nil,
      Txt_ = nil
    },
    Group_OpenTips = {self = nil, Txt_Tips = nil},
    Txt_EffectTips = nil,
    Txt_NotPassTips = nil
  },
  ScrollGrid_DailyQuestHurdle = {
    self = nil,
    grid = {
      self = nil,
      Img_Low = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_LowIcon = nil
      },
      Img_Middle = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_MiddleIcon = nil
      },
      Img_High = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_HighIcon = nil
      },
      Img_Super = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_SuperIcon = nil
      },
      Group_txt = {
        self = nil,
        Txt_QuestName = nil,
        Img_Grade = nil,
        Img_NowLowGrade = nil,
        Img_NowMiddleGrade = nil,
        Img_NowHighGrade = nil,
        Img_NowSuperGrade = nil,
        Txt_QuestDescribe = nil,
        Txt_QuestSuccessNum = nil,
        Img_SuperRecive = nil,
        Img_HighRecive = nil,
        Img_MiddleRecive = nil,
        Img_LowRecive = nil,
        Img_Award = nil,
        Txt_Get = nil,
        Txt_NotGet = nil,
        Btn_LQ = nil,
        Btn_YL = nil,
        Img_Complete = {
          self = nil,
          Txt_B = nil,
          Img_ = nil
        }
      },
      Img_Empty = {
        self = nil,
        Img_ = nil,
        Txt_A = nil,
        Txt_B = nil,
        Btn_JRW = nil
      }
    }
  },
  ScrollGrid_WeekQuestHurdle = {
    self = nil,
    grid = {
      self = nil,
      Img_Low = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_LowIcon = nil
      },
      Img_Middle = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_MiddleIcon = nil
      },
      Img_High = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_HighIcon = nil
      },
      Img_Super = {
        self = nil,
        Img_A = nil,
        Img_B = nil,
        Img_SuperIcon = nil
      },
      Group_txt = {
        self = nil,
        Txt_QuestName = nil,
        Img_Grade = nil,
        Img_NowLowGrade = nil,
        Img_NowMiddleGrade = nil,
        Img_NowHighGrade = nil,
        Img_NowSuperGrade = nil,
        Txt_QuestDescribe = nil,
        Txt_QuestSuccessNum = nil,
        Img_SuperRecive = nil,
        Img_HighRecive = nil,
        Img_MiddleRecive = nil,
        Img_LowRecive = nil,
        Img_Award = nil,
        Txt_Get = nil,
        Txt_NotGet = nil,
        Btn_LQ = nil,
        Btn_YL = nil,
        Img_Complete = {
          self = nil,
          Txt_B = nil,
          Img_ = nil
        }
      }
    }
  },
  Group_QuestPond = {
    self = nil,
    Img_BG = nil,
    Txt_TS = nil,
    Group_BottomBar = {
      self = nil,
      Img_ = nil,
      Txt_Receive = nil,
      Btn_Confirm = {
        self = nil,
        Txt_ = nil,
        Img_ = nil
      },
      Btn_Cancel = {
        self = nil,
        Txt_ = nil,
        Img_ = nil
      }
    },
    ScrollGrid_QuestPond = {
      self = nil,
      grid = {
        self = nil,
        Img_Low = {self = nil, Img_TextBg = nil},
        Img_SelectLow = {self = nil, Img_TextBg = nil},
        Img_Middle = {self = nil, Img_TextBg = nil},
        Img_SelectMiddle = {self = nil, Img_TextBg = nil},
        Img_High = {self = nil, Img_TextBg = nil},
        Img_SelectHigh = {self = nil, Img_TextBg = nil},
        Img_Super = {self = nil, Img_TextBg = nil},
        Img_SelectSuper = {self = nil, Img_TextBg = nil},
        Txt_QuestName = nil,
        Txt_QuestDescribe = nil,
        Img_Award = nil,
        Txt_NotGet = nil,
        Btn_Select = nil
      }
    }
  },
  Group_DayPreview = {
    self = nil,
    Img_Bg = nil,
    Btn_Close = nil,
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
      Img_Effect = nil
    }
  },
  Group_BoxPreview = {
    self = nil,
    Img_Bg = nil,
    Btn_Close = nil,
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
      Img_Effect = nil
    }
  }
}
return NewQuest
