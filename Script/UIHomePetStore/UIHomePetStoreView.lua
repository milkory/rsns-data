local HomePetStore = {
  self = nil,
  Img_B = nil,
  Img_BG = nil,
  Img_BGMask = nil,
  Group_NPCPos = {
    self = nil,
    Group_NPC = {
      self = nil,
      Img_Role = nil,
      SpineAnimation_Character = nil,
      SpineAnimation_Alpha = nil,
      Img_Dialog = {self = nil, Txt_Talk = nil},
      Img_Name = {self = nil, Txt_Name = nil}
    }
  },
  Img_NPCMask = nil,
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
  Group_Main = {
    self = nil,
    Btn_Buy = {
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
    Group_Tab = {
      self = nil,
      Img_Btm = nil,
      Img_Selected = nil,
      Btn_Buy = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Group_On = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Btn_Sell = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Group_On = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      }
    },
    Group_Resources = {
      self = nil,
      Group_GoldCoin = {
        self = nil,
        Img_BG = nil,
        Btn_GoldCoin = nil,
        Img_Icon = nil,
        Txt_Num = nil
      }
    },
    Group_NpcInfoL = {
      self = nil,
      Txt_Title = nil,
      Img_Icon = nil,
      Group_Station = {
        self = nil,
        Img_Icon = nil,
        Txt_Station = nil
      },
      Img_Line = nil,
      Btn_Refresh = nil
    },
    Img_BG = nil,
    Img_SellBG = nil,
    Img_TitleIcon = nil,
    Img_Title = nil,
    Txt_Title = nil,
    Group_StoreTab = {
      self = nil,
      Img_BG = nil,
      Btn_Pet = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil
        },
        Group_On = {
          self = nil,
          Img_BG = {
            self = nil,
            Img_Icon = nil,
            Txt_Name = nil
          }
        }
      },
      Btn_Plant = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil
        },
        Group_On = {
          self = nil,
          Img_BG = {
            self = nil,
            Img_Icon = nil,
            Txt_Name = nil
          }
        }
      },
      Btn_Fish = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil
        },
        Group_On = {
          self = nil,
          Img_BG = {
            self = nil,
            Img_Icon = nil,
            Txt_Name = nil
          }
        }
      },
      Btn_PetStuff = {
        self = nil,
        Group_Off = {
          self = nil,
          Img_Icon = nil,
          Txt_Name = nil
        },
        Group_On = {
          self = nil,
          Img_BG = {
            self = nil,
            Img_Icon = nil,
            Txt_Name = nil
          }
        }
      }
    },
    Group_Buy = {
      self = nil,
      Group_Pet = {
        self = nil,
        Img_BG = nil,
        Img_PetTime = {self = nil, Txt_ = nil},
        Group_Pet1 = {
          self = nil,
          Spine_Pet = nil,
          Img_SoldOut = nil,
          Group_Price = {
            self = nil,
            Img_BG = nil,
            Group_Name = {
              self = nil,
              Img_TypeIcon = nil,
              Txt_Name = nil
            },
            Btn_Money = {
              self = nil,
              Img_MoneyBG = {
                self = nil,
                Group_Money = {self = nil, Img_MoneyIcon = nil},
                Txt_Price = nil
              }
            },
            Img_Line = nil,
            Group_Attribute1 = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_Attribute2 = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            }
          },
          Btn_Pet = nil
        },
        Group_Pet2 = {
          self = nil,
          Spine_Pet = nil,
          Img_SoldOut = nil,
          Group_Price = {
            self = nil,
            Img_BG = nil,
            Group_Name = {
              self = nil,
              Img_TypeIcon = nil,
              Txt_Name = nil
            },
            Btn_Money = {
              self = nil,
              Img_MoneyBG = {
                self = nil,
                Group_Money = {self = nil, Img_MoneyIcon = nil},
                Txt_Price = nil
              }
            },
            Img_Line = nil,
            Group_Attribute1 = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_Attribute2 = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            }
          },
          Btn_Pet = nil
        },
        Group_Pet3 = {
          self = nil,
          Spine_Pet = nil,
          Img_SoldOut = nil,
          Group_Price = {
            self = nil,
            Img_BG = nil,
            Group_Name = {
              self = nil,
              Img_TypeIcon = nil,
              Txt_Name = nil
            },
            Btn_Money = {
              self = nil,
              Img_MoneyBG = {
                self = nil,
                Group_Money = {self = nil, Img_MoneyIcon = nil},
                Txt_Price = nil
              }
            },
            Img_Line = nil,
            Group_Attribute1 = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            },
            Group_Attribute2 = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            }
          },
          Btn_Pet = nil
        }
      },
      Group_PlantByeForNow = {
        self = nil,
        Img_BG = {self = nil, Img_Mask = nil},
        Img_Fence = nil,
        Img_Right = {
          self = nil,
          Img_Pin1 = nil,
          Img_Pin2 = nil
        },
        Img_Left = {
          self = nil,
          Img_Pin1 = nil,
          Img_Pin2 = nil
        },
        Img_Middle = nil,
        Img_FenceMask = nil,
        ScrollGrid_List = {
          self = nil,
          grid = {
            self = nil,
            Img_Flower = nil,
            Img_Pot = nil,
            Img_SoldOut = nil,
            Group_Price = {
              self = nil,
              Img_BG = nil,
              Txt_Name = nil,
              Txt_Price = nil,
              Img_Money = nil,
              Group_Attribute = {
                self = nil,
                Txt_Attribute = nil,
                Img_AttributeIcon = nil,
                Txt_Scores = nil
              }
            },
            Img_Pin = nil
          }
        }
      },
      Group_Fish3Dwaiting = {
        self = nil,
        Img_BG = nil,
        Group_Fish1 = {
          self = nil,
          Img_ = nil,
          Group_Price = {
            self = nil,
            Img_BG = nil,
            Txt_Name = nil,
            Img_Money = {
              self = nil,
              Img_Money = nil,
              Txt_Price = nil
            },
            Img_Line = nil,
            Group_Attribute = {
              self = nil,
              Txt_Attribute = nil,
              Img_AttributeIcon = nil,
              Txt_Scores = nil
            }
          }
        }
      },
      Group_General = {
        self = nil,
        ScrollGrid_List = {
          self = nil,
          grid = {
            self = nil,
            Img_BG = nil,
            Btn_1 = nil,
            Img_Mask = {self = nil, Img_Item = nil},
            Txt_Name = nil,
            Group_Money = {
              self = nil,
              Group_Money = {self = nil, Img_Money = nil},
              Txt_MoneyNum = nil
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
              },
              Group_AttributeLove = {
                self = nil,
                Img_AttributeIcon = nil,
                Txt_Scores = nil
              }
            },
            Img_ShouWan = {self = nil, Img_ = nil}
          }
        },
        Group_Time = {
          self = nil,
          Img_ = nil,
          Txt_Time = nil,
          Img_1 = {self = nil, Btn_ = nil}
        }
      }
    },
    Group_Sell = {
      self = nil,
      Group_General = {
        self = nil,
        ScrollGrid_List = {
          self = nil,
          grid = {
            self = nil,
            Img_BG = nil,
            Btn_1 = nil,
            Img_Mask = {self = nil, Img_Item = nil},
            Txt_Name = nil,
            Group_Money = {
              self = nil,
              Group_Money = {self = nil, Img_Money = nil},
              Txt_MoneyNum = nil
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
              },
              Group_AttributeLove = {
                self = nil,
                Img_AttributeIcon = nil,
                Txt_Scores = nil
              }
            },
            Group_SY = {
              self = nil,
              Img_1 = {
                self = nil,
                Txt_NumDes = nil,
                Txt_Num = nil
              }
            },
            Group_Level = {
              self = nil,
              Img_BG = nil,
              Group_Num = {
                self = nil,
                Txt_LV = nil,
                Txt_Num = nil
              }
            }
          }
        }
      }
    },
    Group_Nothing = {
      self = nil,
      Img_Icon = nil,
      Txt_ = nil
    }
  }
}
return HomePetStore
