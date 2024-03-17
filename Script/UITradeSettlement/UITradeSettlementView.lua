local TradeSettlement = {
  self = nil,
  Img_Blur = nil,
  Btn_Close = nil,
  Group_Sell = {
    self = nil,
    Img_BG = nil,
    Img_Rep = {
      self = nil,
      Img_Btm = nil,
      Txt_Title = nil,
      Txt_LV = nil,
      Txt_Num = nil,
      Group_EXP = {
        self = nil,
        Txt_EXP = nil,
        Txt_Null = nil,
        Img_Arrow = nil
      },
      Img_Line = nil
    },
    Img_Trade = {
      self = nil,
      Img_Btm = nil,
      Txt_Title = nil,
      Txt_LV = nil,
      Txt_Num = nil,
      Img_Line = nil,
      Group_EXP = {
        self = nil,
        Txt_EXP = nil,
        Txt_Null = nil,
        Img_Arrow = nil
      }
    },
    Btn_Ranking = {self = nil, Txt_ = nil},
    Img_4Day = {
      self = nil,
      Txt_Title = nil,
      Txt_TitleEN = nil,
      Img_Title = nil,
      Img_Mark = {
        self = nil,
        Txt_Profit = nil,
        Txt_Cost = nil,
        Img_Profit = nil,
        Img_Cost = nil
      },
      Group_PB4 = {
        self = nil,
        Img_Profit = nil,
        Img_Cost = nil,
        Txt_Day = nil,
        Img_Null = {self = nil, Txt_Null = nil},
        Txt_Profit = nil,
        Txt_Cost = nil
      },
      Group_PB3 = {
        self = nil,
        Img_Profit = nil,
        Img_Cost = nil,
        Txt_Day = nil,
        Img_Null = {self = nil, Txt_Null = nil},
        Txt_Profit = nil,
        Txt_Cost = nil
      },
      Group_PB2 = {
        self = nil,
        Img_Profit = nil,
        Img_Cost = nil,
        Txt_Day = nil,
        Img_Null = {self = nil, Txt_Null = nil},
        Txt_Profit = nil,
        Txt_Cost = nil
      },
      Group_PB1 = {
        self = nil,
        Img_Profit = nil,
        Img_Cost = nil,
        Img_Day = nil,
        Txt_Day = nil,
        Txt_Profit = nil,
        Txt_Cost = nil
      }
    },
    Img_Top3 = {
      self = nil,
      Txt_Title = nil,
      Txt_TitleEN = nil,
      Img_Title = nil,
      Img_PieBtm = nil,
      Img_PieTitle = nil,
      Img_Pie4 = nil,
      Img_Pie3 = nil,
      Img_Pie2 = nil,
      Img_Pie1 = nil,
      Img_Goods = {
        self = nil,
        StaticGrid_Goods = {
          self = nil,
          grid = {self = nil, Img_Goods = nil}
        },
        Img_No1 = nil,
        Img_No2 = nil,
        Img_No3 = nil
      },
      Group_Goods1 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Txt_Num = {self = nil, Img_Icon = nil}
      },
      Group_Goods2 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Txt_Num = {self = nil, Img_Icon = nil}
      },
      Group_Goods3 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Txt_Num = {self = nil, Img_Icon = nil}
      },
      Group_Goods4 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Txt_Num = {self = nil, Img_Icon = nil}
      }
    },
    Group_NPC = {
      self = nil,
      Img_Role = nil,
      SpineAnimation_Character = nil,
      SpineAnimation_Alpha = nil,
      Img_Dialog = {self = nil, Txt_Talk = nil},
      Img_Name = {self = nil, Txt_Name = nil}
    },
    Img_Title = {
      self = nil,
      Txt_Title = nil,
      Txt_TitleEN = nil
    },
    Img_Btm = nil,
    Img_Tax = {
      self = nil,
      Txt_Tax = nil,
      Txt_Num = {self = nil, Img_Icon = nil}
    },
    Img_Price = {
      self = nil,
      Txt_Price = nil,
      Txt_Num = {self = nil, Img_Icon = nil}
    },
    Img_ROI = {
      self = nil,
      Txt_ROI = nil,
      Btn_ROI = nil,
      Txt_Num = nil
    },
    Img_Profit = {
      self = nil,
      Txt_Profit = nil,
      Txt_ProfitEN = nil,
      Txt_Num = nil
    },
    Img_Help = {
      self = nil,
      Btn_Close = nil,
      Txt_Title = nil,
      Txt_Tips = nil
    },
    Img_Ranking = {self = nil, Txt_Num = nil}
  },
  Group_Buy = {
    self = nil,
    Img_BG = nil,
    Img_Rep = {
      self = nil,
      Img_Btm = nil,
      Txt_Title = {
        self = nil,
        Txt_LV = nil,
        Txt_Num = nil
      },
      Group_EXP = {
        self = nil,
        Txt_EXP = nil,
        Txt_Null = nil,
        Img_Arrow = nil
      }
    },
    Img_Top3 = {
      self = nil,
      Img_Title = nil,
      Txt_Title = nil,
      Txt_TitleEN = nil,
      Img_PieBtm = nil,
      Img_Pie4 = nil,
      Img_Pie3 = nil,
      Img_Pie2 = nil,
      Img_Pie1 = nil,
      Img_Goods = {
        self = nil,
        StaticGrid_Goods = {
          self = nil,
          grid = {self = nil, Img_Goods = nil}
        },
        Img_No1 = nil,
        Img_No2 = nil,
        Img_No3 = nil
      },
      Img_ListTitle = {
        self = nil,
        Txt_Name = nil,
        Txt_UnitPrice = nil,
        Txt_TotalPrice = nil
      },
      Img_Goods_Buy1 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Group_UnitPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        },
        Group_TotalPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        }
      },
      Img_Goods_Buy2 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Group_UnitPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        },
        Group_TotalPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        }
      },
      Img_Goods_Buy3 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Group_UnitPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        },
        Group_TotalPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        }
      },
      Img_Goods_Buy4 = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Group_UnitPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        },
        Group_TotalPrice = {
          self = nil,
          Img_Icon = nil,
          Txt_Num = nil
        }
      }
    },
    Group_NPC = {
      self = nil,
      Img_Role = nil,
      SpineAnimation_Character = nil,
      SpineAnimation_Alpha = nil,
      Img_Dialog = {self = nil, Txt_Talk = nil},
      Img_Name = {self = nil, Txt_Name = nil}
    },
    Img_Title = {
      self = nil,
      Txt_Title = nil,
      Txt_TitleEN = nil
    },
    Img_Btm = nil,
    Img_Tax = {
      self = nil,
      Txt_Tax = nil,
      Txt_Num = {self = nil, Img_Icon = nil}
    },
    Img_Price = {
      self = nil,
      Txt_Price = nil,
      Txt_Num = {self = nil, Img_Icon = nil}
    }
  },
  Group_Tips = {
    self = nil,
    Img_Tips = nil,
    Txt_Tips = nil
  }
}
return TradeSettlement
