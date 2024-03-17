local HomeCOC = {
  self = nil,
  Img_B = nil,
  Img_BG = nil,
  Img_BGMask = nil,
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
  Group_NPC = {
    self = nil,
    Img_Role = nil,
    SpineAnimation_Character = nil,
    SpineAnimation_Alpha = nil,
    Img_Dialog = {self = nil, Txt_Talk = nil},
    Img_Name = {self = nil, Txt_Name = nil}
  },
  Img_NPCMask = nil,
  Group_Main = {
    self = nil,
    Btn_Quest = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Btn_Exchange = {
      self = nil,
      Txt_ = nil,
      Img_ = nil,
      Group_Time = {
        self = nil,
        Img_1 = nil,
        Txt_Time = nil
      },
      Img_Limit = {
        self = nil,
        Txt_Dec = nil,
        Img_Icon = nil,
        Img_1 = nil,
        Group_Limit = {
          self = nil,
          Img_2 = nil,
          Txt_Limit = nil
        }
      }
    },
    Btn_Store = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Btn_Talk = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Group_NpcInfo = {
      self = nil,
      Txt_Title = nil,
      Img_Icon = nil,
      Group_Station = {
        self = nil,
        Img_Icon = nil,
        Txt_Station = nil
      },
      Img_Line = nil
    }
  },
  Group_Store = {
    self = nil,
    Group_Resources = {
      self = nil,
      Group_GoldCoin = {
        self = nil,
        Img_BG = nil,
        Btn_GoldCoin = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      }
    },
    Img_BG = {self = nil, Img_ = nil},
    Group_Furniture = {
      self = nil,
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_BG = nil,
          Img_ = nil,
          Btn_1 = nil,
          Img_Mask = {self = nil, Img_Item = nil},
          Img_Mask1 = nil,
          Txt_Name = nil,
          Img_Quality = nil,
          Img_Time = {self = nil, Txt_Time = nil},
          Group_SY = {
            self = nil,
            Img_1 = nil,
            Txt_Num = nil
          },
          Group_Money = {
            self = nil,
            Img_Money = nil,
            Txt_MoneyNum = nil,
            Txt_ = nil
          },
          Group_Attribute = {
            self = nil,
            Group_AttributePlant = {
              self = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_AttributeFish = {
              self = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_AttributePet = {
              self = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_AttributeAppetite = {
              self = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_AttributeComfort = {
              self = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            }
          },
          Img_ShouWan = {self = nil, Img_ = nil},
          Img_AllLimit = {
            self = nil,
            Img_ = nil,
            Group_1 = {
              self = nil,
              Txt_Rep = nil,
              Txt_Grade = nil
            }
          }
        }
      }
    },
    Group_StoreTab = {
      self = nil,
      Img_BG = {self = nil, Img_ = nil},
      ScrollGrid_Tab = {
        self = nil,
        grid = {
          self = nil,
          Btn_Furniture = {
            self = nil,
            Group_Off = {
              self = nil,
              Img_Icon = nil,
              Txt_Name = nil
            },
            Group_On = {
              self = nil,
              Img_BG = nil,
              Txt_Name = nil,
              Img_Icon = nil
            }
          }
        }
      }
    },
    Group_Time = {
      self = nil,
      Txt_Time = nil,
      Img_1 = {self = nil, Btn_ = nil}
    },
    Img_LittleTittle = nil,
    Txt_Title = nil,
    Img_Fornitureicon = nil
  },
  Group_NpcInfo = {
    self = nil,
    Txt_Title = nil,
    Img_Icon = nil,
    Group_Station = {
      self = nil,
      Img_Icon = nil,
      Txt_Station = nil
    },
    Img_Line = nil
  },
  Group_Reputation = {
    self = nil,
    Btn_Reputation = {self = nil, Img_Click = nil},
    Txt_Grade = nil,
    Txt_Num = nil,
    Img_PBBG = nil,
    Img_PB = nil,
    Img_RedPoint = nil
  },
  Group_Quest = {
    self = nil,
    ScrollGrid_QuestList = {
      self = nil,
      grid = {
        self = nil,
        Group_Info = {
          self = nil,
          Img_Btm = nil,
          Img_Btm2 = nil,
          Img_Name = nil,
          Img_Type = nil,
          Txt_Type = nil,
          Txt_Name = nil,
          Group_Time = {
            self = nil,
            Img_ = nil,
            Txt_Time = nil
          },
          Img_ClientMask = {self = nil, Img_Client = nil},
          Img_ClientM2 = nil,
          Group_Reward = {
            self = nil,
            Img_BG = nil,
            Img_Icon = {self = nil, Txt_T = nil},
            ScrollGrid_Reward = {
              self = nil,
              grid = {
                self = nil,
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
                  Group_EType = {
                    self = nil,
                    Img_IconBg = nil,
                    Img_Icon = nil
                  },
                  Img_TimeLeft = {
                    self = nil,
                    Img_ = nil,
                    Txt_ = nil
                  },
                  Group_Extra = {
                    self = nil,
                    Img_bg = {self = nil, Txt_txt = nil}
                  },
                  Group_Effect = nil
                }
              }
            }
          },
          Btn_Info = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Btn_Info2 = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Txt_Client = nil,
          Group_Station = {
            self = nil,
            Group_Ing = {
              self = nil,
              Txt_ = nil,
              Img_ = nil
            },
            Img_P = nil,
            Txt_EndStation = nil
          },
          Group_NeedLoadage = {
            self = nil,
            Img_Icon = nil,
            Txt_ = nil,
            Txt_Num = nil
          },
          Group_NeedPassengerCapacity = {
            self = nil,
            Img_Icon = nil,
            Txt_ = nil,
            Txt_Num = nil
          }
        },
        Group_AddQuest = {
          self = nil,
          Img_ = nil,
          Btn_ = {
            self = nil,
            Txt_ = nil,
            Img_ = nil
          }
        }
      }
    },
    Group_Tips = {
      self = nil,
      Img_BG = nil,
      Txt_Tips = nil,
      Img_Icon = nil
    },
    Group_QuestNum = {
      self = nil,
      Img_BG = nil,
      Txt_Tips = nil,
      Txt_Num = nil
    },
    Group_PassengerCapacity = {
      self = nil,
      Img_BG = nil,
      Img_PBBG = nil,
      Img_PB = nil,
      Txt_Num = nil,
      Btn_Add = {self = nil, Img_Click = nil},
      Btn_Icon = nil
    },
    Group_Loadage = {
      self = nil,
      Img_BG = nil,
      Img_PBBG = nil,
      Img_PB = nil,
      Txt_Num = nil,
      Btn_Add = {self = nil, Img_Click = nil},
      Btn_Icon = nil
    },
    Group_QuestInfo = {
      self = nil,
      Btn_BG = nil,
      Img_Btm = nil,
      Group_Map = {
        self = nil,
        Img_BG = nil,
        Content = {
          self = nil,
          Img_Water = nil,
          RawImg_Map = nil,
          Group_OnlyShow = {
            self = nil,
            RawImg_MapEF = nil,
            RawImg_Line = nil,
            RawImg_Water = nil,
            RawImg_OutLine = nil
          },
          Img_Tex = nil,
          RawImg_Line = nil,
          Btn_Close = nil,
          Group_Dungeon = nil,
          Group_Pollte = {
            self = nil,
            Group_Pollute = {
              self = nil,
              Img_Icon = nil,
              Txt_Des = nil,
              Txt_Num = nil
            }
          },
          ScrollGrid_Station = {
            self = nil,
            grid = {
              self = nil,
              Btn_S1 = {
                self = nil,
                Txt_Name = nil,
                Img_ClickArea = nil
              }
            }
          },
          Img_Train = nil,
          Img_Selected = nil
        },
        Img_Block = nil,
        Group_Position = {
          self = nil,
          Img_P1 = nil,
          Img_P2 = nil
        }
      },
      Img_Compass = nil,
      Img_Btm_Info = {self = nil, Img_ = nil},
      Group_Time = {
        self = nil,
        Img_Btm = nil,
        Txt_Time = nil,
        Img_Time = nil
      },
      Txt_Title = nil,
      Img_CientB = nil,
      Img_ClientMask = {self = nil, Img_Client = nil},
      Img_CientF = nil,
      Txt_Client = nil,
      Img_Line = nil,
      ScrollView_Describe = {
        self = nil,
        Viewport = {self = nil, Txt_Describe = nil}
      },
      Img_Btm_G = nil,
      ScrollGrid_Goods = {
        self = nil,
        grid = {
          self = nil,
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
            Group_EType = {
              self = nil,
              Img_IconBg = nil,
              Img_Icon = nil
            },
            Group_Effect = nil,
            Img_Send = nil,
            Img_Specialty = nil,
            Group_Extra = {
              self = nil,
              Img_bg = {self = nil, Txt_txt = nil}
            },
            Img_TimeLeft = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            }
          }
        }
      },
      Img_Space = nil,
      Txt_Space_Goods = nil,
      ScrollGrid_Passenger = {
        self = nil,
        grid = {
          self = nil,
          Group_Passenger = {
            self = nil,
            Img_ClientMask = {self = nil, Img_Client = nil},
            Img_CientF = nil,
            Txt_Num = nil
          }
        }
      },
      Img_Passenger = nil,
      Txt_Space_Passenger = nil,
      Txt_Space = nil,
      Img_PBBG = nil,
      Img_PBAfter = nil,
      Img_PBNow = nil,
      Img_Btm_Rrward = nil,
      Img_Reward = nil,
      Txt_R = nil,
      ScrollGrid_Reward = {
        self = nil,
        grid = {
          self = nil,
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
            Group_EType = {
              self = nil,
              Img_IconBg = nil,
              Img_Icon = nil
            },
            Img_TimeLeft = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            },
            Group_Extra = {
              self = nil,
              Img_bg = {self = nil, Txt_txt = nil}
            },
            Group_Effect = nil
          }
        }
      },
      Btn_Cancel = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      },
      Btn_Receive = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      },
      Btn_Next = nil,
      Btn_Prev = nil,
      Group_Tips = {
        self = nil,
        Img_Tips = nil,
        Txt_Tips = nil
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
  }
}
return HomeCOC
