local MainUI = {
  self = nil,
  Img_Block = nil,
  Img_RT = nil,
  Btn_Launch = {
    self = nil,
    Txt_ZH = nil,
    Txt_EN = nil
  },
  Btn_City = {
    self = nil,
    Txt_Name = nil,
    Txt_CityName = nil,
    Img_P = nil,
    Img_A = nil,
    Img_RedPoint = nil
  },
  Btn_Dungeon = {
    self = nil,
    Txt_Name = nil,
    Txt_CityName = nil,
    Img_P = nil,
    Img_A = nil
  },
  Img_Dashboard = nil,
  Group_OutSide = {
    self = nil,
    Group_Station = {
      self = nil,
      Btn_Build = {
        self = nil,
        Img_Lock = nil,
        Txt_ = nil
      },
      Btn_SellG = {self = nil, Txt_ = nil},
      Btn_HandleG = {
        self = nil,
        Img_Lock = nil,
        Txt_ = nil
      },
      Btn_Visit = {
        self = nil,
        Img_Lock = nil,
        Txt_ = nil
      }
    },
    Group_Running = {
      self = nil,
      Btn_Horn = nil,
      Btn_Accelerate = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_Icon = nil,
          Img_Bg = nil,
          Txt_Num = nil
        },
        Group_On = {
          self = nil,
          Img_Icon = nil,
          Img_Bg = nil,
          Txt_Num = nil,
          Img_On = nil
        },
        Group_Ing = {
          self = nil,
          Img_Bg = nil,
          Img_Bar = nil,
          Txt_Des = nil,
          Txt_Time2 = nil,
          Txt_Time = nil,
          Group_RushTime = nil,
          Group_RushBuyBtn = nil
        }
      },
      Group_Gear = {
        self = nil,
        Img_Btm = nil,
        Btn_D = {
          self = nil,
          Group_Off = {self = nil, Img_D = nil},
          Group_On = {self = nil, Img_D = nil}
        },
        Btn_B = {
          self = nil,
          Group_Off = {self = nil, Img_B = nil},
          Group_On = {self = nil, Img_B = nil}
        },
        Btn_R = {
          self = nil,
          Group_Off = {self = nil, Img_R = nil},
          Group_On = {self = nil, Img_R = nil}
        },
        Img_Gear = nil,
        Group_Sound = {
          self = nil,
          Group_SoundDownToB = nil,
          Group_SoundDownToR = nil,
          Group_SoundUpToB = nil,
          Group_SoundUpToD = nil
        }
      },
      Btn_Mask = nil,
      Btn_Camera = nil,
      Group_RushEffect = nil,
      Btn_Light = {
        self = nil,
        Group_On = {self = nil, Img_On = nil},
        Group_Off = {self = nil, Img_Off = nil}
      },
      Group_StrikeEffect = nil
    }
  },
  Group_Adjutant = {
    self = nil,
    Img_BG = nil,
    Btn_TrainOverview = {self = nil, Txt_ = nil},
    Btn_DrivingLog = {self = nil, Txt_ = nil},
    Btn_Achieve = {
      self = nil,
      Txt_ = nil,
      Img_Red = nil
    }
  },
  Group_Coach = {
    self = nil,
    Group_QuickJump = {
      self = nil,
      Btn_DecorateOFF = {self = nil, Txt_Navigation = nil},
      Btn_Close = nil,
      Btn_DecorateON = {
        self = nil,
        Img_Select = nil,
        Txt_Navigation = nil
      },
      Group_Windows = {
        self = nil,
        Group_QuickJump = {
          self = nil,
          Img_QuickJump = {self = nil, Txt_QuickJump = nil}
        },
        Img_Base = {
          self = nil,
          StaticGrid_Train = {
            self = nil,
            grid = {
              self = nil,
              Btn_train = {
                self = nil,
                Img_Select = {
                  self = nil,
                  Img_people = nil,
                  Img_Icon = nil,
                  Txt_Select = nil
                },
                Img_UnSelect = {
                  self = nil,
                  Txt_UnSelect = nil,
                  Img_Icon = nil
                },
                Img_Empty = {self = nil, Txt_Empty = nil}
              }
            }
          }
        },
        Group_train = {
          self = nil,
          Btn_train = {
            self = nil,
            Img_Select = {
              self = nil,
              Img_people = nil,
              Img_Icon = nil,
              Txt_Select = nil
            },
            Img_UnSelect = {
              self = nil,
              Txt_UnSelect = nil,
              Img_Icon = nil
            },
            Img_Empty = {self = nil, Txt_Empty = nil}
          }
        }
      }
    },
    Btn_Decorate = {self = nil, Txt_ = nil},
    Btn_Manager = {self = nil, Txt_ = nil},
    Img_Control = {
      self = nil,
      Btn_PetManage = {
        self = nil,
        Img_Pet = nil,
        Txt_ = nil
      },
      Btn_Passenger = {
        self = nil,
        Txt_ = nil,
        Img_Passenger = nil,
        Img_Lock = nil,
        Txt_num = nil
      }
    }
  },
  Group_Common = {
    self = nil,
    Group_PosterGirl = {
      self = nil,
      Group_Mask = {
        self = nil,
        Img_BG = nil,
        Img_Top = nil,
        Img_Down = nil
      },
      Img_SpineBG = nil,
      SpineSecondMode_Character = nil,
      SpineAnimation_CharacterEffect = nil,
      SpineAnimation_Character = nil,
      Group_SpineAnimationAlpha = nil,
      Group_Character = {self = nil, Sprite_Character = nil},
      Group_CharacterIMG = {self = nil, Img_Character = nil},
      Btn_ChangeAnimation = nil,
      Btn_ChangeAnimation2 = nil,
      Btn_Change = {
        self = nil,
        Txt_T = nil,
        Txt_E = nil
      },
      Btn_GetTrust = {
        self = nil,
        Txt_T = nil,
        Txt_E = nil
      },
      Btn_FestivalGift = {
        self = nil,
        Img_small = nil,
        Img_big = nil,
        Img_main = nil,
        Txt_1 = nil,
        Txt_2 = nil,
        Txt_3 = nil
      }
    },
    Img_DialogBox = {self = nil, Txt_Dialog = nil},
    Group_Navigation = {
      self = nil,
      Btn_Quest = {
        self = nil,
        Img_Click = nil,
        Txt_Name = nil,
        Img_New = nil
      },
      Img_Line = nil,
      Btn_Navigation = {self = nil, Txt_Target = nil}
    },
    Group_TopLeft = {
      self = nil,
      Img_BtmPP = nil,
      Btn_ProfilePhoto = {self = nil, Img_Client = nil},
      Img_EXPBG = nil,
      Img_EXPPB = nil,
      Img_Remind = nil,
      Btn_Gold = {
        self = nil,
        Img_Btm = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Txt_G = nil
      },
      Txt_Name = nil,
      Group_Buff = {
        self = nil,
        Img_BuffSpeed = {self = nil, Btn_ = nil},
        Img_Buff = {self = nil, Btn_ = nil},
        Img_BuffBattle = {self = nil, Btn_ = nil}
      },
      Group_LV = {
        self = nil,
        Txt_ = nil,
        Txt_Num = nil
      },
      Txt_UID = nil
    },
    Group_TopRight = {
      self = nil,
      Btn_ActivityNew = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Activity = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Mission = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Store = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Headhunt = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Depot = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Squads = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      },
      Btn_Member = {
        self = nil,
        Txt_Name = nil,
        Img_Remind = {self = nil, Txt_Num = nil}
      }
    },
    Group_MB = {
      self = nil,
      BtnPolygon_Adjutant = {
        self = nil,
        Txt_Left = {
          self = nil,
          Img_Arrow = nil,
          Img_Click = nil
        },
        Txt_Right = {
          self = nil,
          Img_Arrow = nil,
          Img_Click = nil
        }
      },
      BtnPolygon_OutSide = {
        self = nil,
        Txt_Left = {
          self = nil,
          Img_Arrow = nil,
          Img_Click = nil
        },
        Txt_Right = {
          self = nil,
          Img_Arrow = nil,
          Img_Click = nil
        }
      },
      BtnPolygon_Coach = {
        self = nil,
        Txt_Left = {
          self = nil,
          Img_Arrow = nil,
          Img_Click = nil
        },
        Txt_Right = {
          self = nil,
          Img_Arrow = nil,
          Img_Click = nil
        }
      },
      Img_Speed = {
        self = nil,
        Img_Blur = nil,
        Img_S = nil,
        Txt_Speed = nil,
        Txt_SpeedUnit = nil,
        Txt_Num = nil,
        Txt_Unit = nil,
        Img_Pointer = nil,
        Txt_N = nil,
        Txt_S = nil,
        Img_BP = nil
      },
      Group_Strike = {
        self = nil,
        Img_Bg = nil,
        Img_Blur = nil,
        Img_S = nil,
        Txt_S = nil,
        Txt_Current = nil,
        Txt_Total = nil,
        Txt_Connect = nil,
        Img_hpIcon = nil,
        Txt_hpRatio = nil,
        Img_BP = nil,
        Group_Start = {
          self = nil,
          Txt_Success = nil,
          Txt_N = nil
        },
        Group_Ready = {self = nil, Txt_N = nil}
      },
      Img_Durability = {
        self = nil,
        SpineAnimation_Box = nil,
        Txt_Durability = nil,
        Img_Durability = nil,
        Img_PB = nil,
        Txt_D = nil,
        Txt_DurPCT = nil,
        Group_SpineAnimationAlpha = nil,
        Group_Ready = {self = nil, Txt_N = nil},
        Group_Start = {
          self = nil,
          Txt_Success = nil,
          Txt_N = nil
        }
      },
      Group_PollutionIndex = {
        self = nil,
        Img_Mask = {
          self = nil,
          Group_Color = {self = nil, Img_Color = nil}
        },
        Img_Now = nil
      },
      Btn_Electric = nil,
      Group_Lighting = nil,
      SpineNode_Warning = {self = nil, Group_Sound = nil},
      SpineNode_Rush = nil
    },
    Group_Position = {
      self = nil,
      Img_ProcessBar = {
        self = nil,
        Img_PB = nil,
        Img_PositionMark = nil,
        Img_Mask = nil
      },
      Txt_Distance = nil,
      Txt_Destination = nil,
      Img_Cruise = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      }
    },
    Btn_Enter = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Btn_Leave = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Btn_Help = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    SoftMask_HomeMap = {
      self = nil,
      Group_HomeMap = {
        self = nil,
        ScrollView_Map = {
          self = nil,
          Viewport = {
            self = nil,
            Content = {
              self = nil,
              Img_Water = nil,
              RawImg_Map = nil,
              Group_OnlyShow = {
                self = nil,
                RawImg_Water = nil,
                RawImg_MapEF = nil,
                RawImg_Line = nil,
                RawImg_OutLine = nil
              },
              Img_Tex = nil,
              RawImg_Line = nil,
              Btn_Close = nil,
              Group_Dungeon = {
                self = nil,
                Group_Dungeon = {self = nil, Img_Icon = nil}
              },
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
            }
          }
        },
        Group_StationInfo = {
          self = nil,
          Img_Blur = nil,
          Img_Btm = nil,
          Group_Info = {
            self = nil,
            Group_Station = {
              self = nil,
              Img_Btm = nil,
              Txt_Distance = nil,
              Group_Type1 = {
                self = nil,
                Img_ = nil,
                Txt_ = nil
              },
              Group_Type2 = {
                self = nil,
                Img_ = nil,
                Txt_ = nil
              },
              Group_Type3 = {
                self = nil,
                Img_ = nil,
                Txt_ = nil
              },
              Txt_Name = nil
            },
            Group_City = {
              self = nil,
              Group_Development = {
                self = nil,
                Img_ = nil,
                Txt_Development = nil
              },
              Group_Reputation = {
                self = nil,
                Img_ = nil,
                Txt_Reputation = nil
              }
            },
            Group_Desc = {
              self = nil,
              Txt_ = nil,
              Img_Line = nil,
              ScrollView_Des = {
                self = nil,
                Viewport = {self = nil, Txt_Des = nil}
              }
            }
          },
          Group_Goods = {
            self = nil,
            Img_Title = nil,
            Txt_Title = nil,
            Img_GB = nil,
            ScrollGrid_GoodsList = {
              self = nil,
              grid = {
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
                Img_TimeLeft = {
                  self = nil,
                  Img_ = nil,
                  Txt_ = nil
                },
                Img_Specialty = nil,
                Group_Extra = {
                  self = nil,
                  Img_bg = {self = nil, Txt_txt = nil}
                },
                Group_Effect = nil,
                Group_EType = {
                  self = nil,
                  Img_IconBg = nil,
                  Img_Icon = nil
                }
              }
            },
            Img_L1 = nil,
            Img_L2 = nil,
            Img_L3 = nil,
            Img_L4 = nil
          },
          Img_Ban = {self = nil, Txt_ = nil},
          Img_Lock = {self = nil, Txt_Condition = nil},
          Btn_Go = {
            self = nil,
            Txt_ = nil,
            Group_Cost = {
              self = nil,
              Img_ = nil,
              Txt_Num = nil
            }
          },
          Btn_Trailer = {
            self = nil,
            Txt_Title = nil,
            Img_Icon = nil,
            Group_Num = {
              self = nil,
              Img_ = nil,
              Txt_Num = nil
            }
          },
          Btn_BuyRush = {
            self = nil,
            Txt_Title = nil,
            Img_Icon = nil,
            Group_Num = {
              self = nil,
              Img_ = nil,
              Txt_Num = nil
            }
          },
          Btn_DriveSetup = {
            self = nil,
            Txt_Title = nil,
            Img_Icon = nil
          }
        },
        Group_Energy = {
          self = nil,
          Img_BG = nil,
          Img_Icon = nil,
          Txt_Num = nil,
          Img_PBBG = nil,
          Img_PB = nil,
          Btn_Energy = nil
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
        Group_HomeEnergy = {
          self = nil,
          Img_BG = nil,
          Img_PBBG = nil,
          Img_PB = nil,
          Txt_Num = nil,
          Btn_Add = {self = nil, Img_Click = nil},
          Btn_Icon = nil
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
        },
        Img_Compass = nil
      },
      Btn_Map = nil,
      Group_MapActive = nil
    },
    Img_Directional = nil,
    Btn_HidePosterGirl = nil,
    Btn_HideUI = nil,
    Group_Back = {
      self = nil,
      Btn_Fight = {
        self = nil,
        Txt_Name = nil,
        Img_Icon = nil
      }
    },
    Group_Event = {
      self = nil,
      Img_Black = nil,
      Group_Bg = {
        self = nil,
        Img_Line = nil,
        Img_Black = nil,
        Img_Bg = {
          self = nil,
          Img_Icon = nil,
          Txt_Des = nil
        }
      },
      Group_ = {
        self = nil,
        Img_ = nil,
        Txt_Name = nil
      },
      Group_Fight = {
        self = nil,
        Group_Fight = {
          self = nil,
          Img_bg = nil,
          Txt_Name = nil,
          Img_Icon = nil
        },
        BtnPolygon_Fight = {
          self = nil,
          Polygon = nil,
          Img_bg = nil,
          Txt_Name = nil,
          Img_Icon = nil,
          Txt_Cost = nil,
          Txt_Lv = nil
        }
      },
      Group_Strike = {
        self = nil,
        Group_Strike = {
          self = nil,
          Img_bg = nil,
          Img_ = nil,
          Txt_Name = nil
        },
        BtnPolygon_Strike = {
          self = nil,
          Polygon = nil,
          Img_bg = nil,
          Img_Icon = nil,
          Txt_Name = nil,
          Txt_Cost = nil
        }
      },
      Group_Buy = {
        self = nil,
        Group_Buy = {
          self = nil,
          Img_bg = nil,
          Img_ = nil,
          Txt_Name = nil
        },
        BtnPolygon_Buy = {
          self = nil,
          Polygon = nil,
          Img_bg = nil,
          Img_Icon = nil,
          Txt_Des = nil
        }
      },
      Group_Balloon = {
        self = nil,
        Group_Balloon = {
          self = nil,
          Img_bg = nil,
          Img_ = nil,
          Txt_Name = nil
        },
        BtnPolygon_Balloon = {
          self = nil,
          Polygon = nil,
          Img_bg = nil,
          Img_Icon = nil,
          Txt_Des = nil
        }
      },
      Group_Back = {
        self = nil,
        Btn_Fight = {
          self = nil,
          Txt_Name = nil,
          Img_Icon = nil
        }
      }
    },
    Btn_ClickFight = {
      self = nil,
      Img_Icon = nil,
      Txt_T = nil,
      Txt_Name = nil,
      Txt_Lv = nil
    }
  },
  Btn_ShowUI = nil,
  Group_Park = {
    self = nil,
    Btn_Park = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    },
    Btn_Start = {
      self = nil,
      Txt_Name = nil,
      Img_Icon = nil
    }
  },
  Btn_AdBoard = {self = nil, Txt_ = nil}
}
return MainUI
