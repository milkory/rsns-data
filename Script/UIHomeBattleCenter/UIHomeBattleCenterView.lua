local HomeBattleCenter = {
  self = nil,
  Img_BG = nil,
  Img_BGMask = nil,
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
    Btn_Battle = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    },
    Btn_Order = {
      self = nil,
      Txt_ = nil,
      Img_ = nil,
      Img_Rep = {
        self = nil,
        Txt_ = nil,
        Img_ = nil,
        Img_1 = nil,
        Img_2 = nil,
        Txt_Rep = nil
      }
    },
    Btn_Income = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    },
    Btn_Talk = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    },
    Group_NpcInfo = {
      self = nil,
      Group_Dingwei = {
        self = nil,
        Img_ = nil,
        Txt_Station = nil
      },
      Img_Icon = nil,
      Txt_Name = nil,
      Img_1 = nil
    },
    Group_Btn = {
      self = nil,
      Btn_List = {
        self = nil,
        Txt_Dec = nil,
        Img_Icon = nil,
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
          Img_2 = nil,
          Txt_Time = nil
        }
      }
    },
    StaticGrid_List = {
      self = nil,
      grid = {
        self = nil,
        Btn_List = {
          self = nil,
          Txt_Dec = nil,
          Img_Icon = nil,
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
            Img_2 = nil,
            Txt_Time = nil
          }
        }
      }
    }
  },
  Group_Zhu = {
    self = nil,
    Txt_Name = nil,
    Img_2 = nil,
    Group_Dingwei = {
      self = nil,
      Img_ = nil,
      Txt_Station = nil
    },
    Group_Construct = {
      self = nil,
      Btn_Construct = {self = nil, Img_Click = nil},
      Txt_Dec = nil,
      Txt_Num = nil,
      Img_PBBG = nil,
      Img_PB = nil,
      Img_RedPoint = nil
    },
    Img_Icon = nil
  },
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
  Group_Battle = {
    self = nil,
    Group_Ding = {
      self = nil,
      Btn_Energy = {
        self = nil,
        Img_BG = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      }
    },
    Group_1 = {
      self = nil,
      Img_ = nil,
      Img_1 = nil,
      Img_2 = nil,
      Group_Top = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil
      },
      Group_Information = {
        self = nil,
        Txt_Name = nil,
        Txt_Dec = nil,
        Txt_ = nil,
        Img_HuaTui = {
          self = nil,
          Txt_1 = nil,
          Txt_Grade = nil,
          Img_ = nil
        },
        Img_Tuijian = {
          self = nil,
          Txt_1 = nil,
          Txt_Grade = nil,
          Img_ = nil
        },
        Group_TZ = {
          self = nil,
          Btn_QW = {self = nil, Txt_ = nil},
          Img_1 = nil,
          Txt_ = nil,
          Txt_Cost = nil
        },
        Group_Reward = {
          self = nil,
          Img_ = nil,
          Img_1 = nil,
          Txt_ = nil
        },
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
            },
            Group_First = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            },
            Group_Allready = {self = nil, Img_ = nil}
          }
        },
        Group_Limit = {
          self = nil,
          Img_ = nil,
          Img_ = nil,
          Txt_Limit = nil
        }
      },
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_Di = nil,
          Img_SelectDi = nil,
          Img_Icon = nil,
          Txt_Grade = nil,
          Txt_ = nil,
          Txt_ = nil,
          Txt_ = nil,
          Group_Limit = {
            self = nil,
            Img_ = nil,
            Img_Limit = nil
          },
          Group_Clear = {self = nil, Img_Clear = nil},
          Img_Select = nil,
          Btn_ = nil
        }
      },
      Img_Arrows = nil
    }
  },
  Group_Sale = {
    self = nil,
    Group_Ding = {
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
    Group_Middle = {
      self = nil,
      Img_BG = nil,
      Img_Di = nil,
      Group_Empty = {
        self = nil,
        Img_1 = nil,
        Txt_1 = nil
      },
      Img_TitleBg = nil,
      Group_Title = {
        self = nil,
        Img_Title = nil,
        Txt_Title = nil
      },
      Group_Switch = {
        self = nil,
        Img_ = nil,
        Group_Single = {
          self = nil,
          Group_Off = {
            self = nil,
            Txt_ = nil,
            Img_ = nil
          },
          Group_On = {
            self = nil,
            Txt_ = nil,
            Img_ = nil
          },
          Btn_ = nil
        },
        Group_Batch = {
          self = nil,
          Group_Off = {
            self = nil,
            Txt_ = nil,
            Img_ = nil
          },
          Group_On = {
            self = nil,
            Txt_ = nil,
            Img_ = nil
          },
          Btn_ = nil
        }
      },
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Btn_ = nil,
          Img_ = nil,
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
          },
          Txt_Name = nil,
          Group_Num = {
            self = nil,
            Img_Up = nil,
            Img_ = nil,
            Txt_Num = nil
          },
          Group_Select = {
            self = nil,
            Img_ = nil,
            Img_ = nil,
            Txt_ = nil
          }
        }
      },
      Group_Di = {
        self = nil,
        Btn_Sale = {
          self = nil,
          Txt_ = nil,
          Img_ = nil
        },
        Img_ = nil,
        Img_ = nil,
        Txt_ = nil,
        Txt_ = nil,
        Group_Earnings = {
          self = nil,
          Img_ = nil,
          Txt_Num = nil
        },
        Txt_SelectNum = nil,
        Group_SelectAll = {
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
          },
          Btn_ = nil
        },
        Group_SelectSSR = {
          self = nil,
          Group_Off = {self = nil, Img_ = nil},
          Group_On = {self = nil, Img_ = nil},
          Btn_ = nil
        },
        Group_SelectSR = {
          self = nil,
          Group_Off = {self = nil, Img_ = nil},
          Group_On = {self = nil, Img_ = nil},
          Btn_ = nil
        },
        Group_SelectR = {
          self = nil,
          Group_Off = {self = nil, Img_ = nil},
          Group_On = {self = nil, Img_ = nil},
          Btn_ = nil
        },
        Group_SelectN = {
          self = nil,
          Group_Off = {self = nil, Img_ = nil},
          Group_On = {self = nil, Img_ = nil},
          Btn_ = nil
        }
      },
      Img_2 = nil,
      Group_Up = {
        self = nil,
        Img_ = nil,
        Img_ = nil,
        Txt_ = nil,
        Btn_ = nil,
        Img_RedPoint = nil
      },
      Group_UpTips = {
        self = nil,
        Btn_ = nil,
        Img_Di = nil,
        Img_ = nil,
        Img_ = nil,
        Img_ = nil,
        Txt_ = nil,
        Txt_ = nil,
        Img_Up = {
          self = nil,
          Txt_Num = nil,
          Txt_ = nil
        },
        ScrollGrid_List = {
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
      }
    }
  },
  Group_Exchange = {
    self = nil,
    Group_Ding = {
      self = nil,
      Group_GoldCoin = {
        self = nil,
        Img_BG = nil,
        Btn_GoldCoin = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      },
      Group_Time = {
        self = nil,
        Img_BG = nil,
        Txt_Time = nil,
        Btn_Tips = {self = nil, Img_Click = nil}
      }
    },
    Group_Middle = {
      self = nil,
      Img_BG = nil,
      Img_Di = nil,
      Img_TitleBg = nil,
      Group_Title = {
        self = nil,
        Img_Title = nil,
        Txt_Title = nil
      },
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_Di = nil,
          Img_Icon = {self = nil, Btn_ = nil},
          Group_Name = {
            self = nil,
            Img_ = nil,
            Txt_Name = nil
          },
          Group_Num = {
            self = nil,
            Img_Bg = nil,
            Img_ = nil,
            Txt_Num = nil
          },
          Group_Item = {
            self = nil,
            Img_ = nil,
            Img_ = nil,
            Img_ = nil,
            Group_Consume1 = {
              self = nil,
              Img_NeedBottom = nil,
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
              },
              Group_Cost = {
                self = nil,
                Txt_Have = nil,
                Txt_And = nil,
                Txt_Need = nil
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
              },
              Group_Cost = {
                self = nil,
                Txt_Have = nil,
                Txt_And = nil,
                Txt_Need = nil
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
              },
              Group_Cost = {
                self = nil,
                Txt_Have = nil,
                Txt_And = nil,
                Txt_Need = nil
              },
              Group_Break = {
                self = nil,
                Img_Mask = {self = nil, Img_Face = nil},
                Img_F = nil
              }
            }
          },
          Group_Time = {
            self = nil,
            Img_ = nil,
            Txt_Time = nil
          },
          Group_Btn = {
            self = nil,
            Group_Can = {
              self = nil,
              Img_ = nil,
              Btn_ = nil
            },
            Group_Not = {
              self = nil,
              Img_ = nil,
              Btn_ = nil
            }
          },
          Group_Extra = {
            self = nil,
            Txt_Num = nil,
            Img_Icon = {self = nil, Btn_ = nil}
          },
          Group_Allready = {
            self = nil,
            Img_ = nil,
            Group_ = {
              self = nil,
              Img_Bg = nil,
              Img_ = nil,
              Txt_ = nil
            }
          }
        }
      }
    }
  },
  Group_Order = {
    self = nil,
    Group_Ding = {
      self = nil,
      Btn_Energy = {
        self = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      },
      Btn_YN = {
        self = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      },
      Group_GoldCoin = {
        self = nil,
        Img_BG = nil,
        Btn_GoldCoin = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      }
    },
    Group_1 = {
      self = nil,
      Img_ = {self = nil, Txt_Title = nil},
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_ = nil,
          Btn_ = nil,
          Group_Submit = {
            self = nil,
            Img_ = nil,
            Img_1 = nil,
            Txt_ = nil
          },
          Txt_ = nil,
          Txt_Num = nil,
          Txt_Name = nil,
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
          },
          Group_Off = {
            self = nil,
            Txt_ = nil,
            Img_ = nil
          },
          Group_On = {
            self = nil,
            Txt_ = nil,
            Img_ = nil,
            Img_1 = nil
          },
          Group_Limit = {
            self = nil,
            Img_ = nil,
            Txt_Num = nil,
            Txt_Name = nil,
            Txt_ = nil,
            Img_1 = nil,
            Img_2 = nil,
            Img_3 = nil,
            Group_Time = {
              self = nil,
              Img_ = nil,
              Img_ = nil,
              Txt_Time = nil
            },
            Group_Other = {
              self = nil,
              Txt_Other = {self = nil, Img_ = nil}
            }
          }
        }
      },
      Group_Dec = {
        self = nil,
        Img_1 = nil,
        Img_ = nil,
        Img_2 = nil,
        Group_Reward = {
          self = nil,
          Img_1 = nil,
          Txt_ = nil,
          Btn_Exchange = nil,
          Btn_Delivery = {self = nil, Txt_ = nil},
          Btn_NotDelivery = {self = nil, Txt_ = nil},
          Btn_QuestSign = {self = nil, Txt_ = nil},
          Btn_NotQuestSign = {self = nil, Txt_ = nil}
        },
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
      }
    }
  },
  Group_Ticket = {
    self = nil,
    Group_TicketProfit = {
      self = nil,
      glass = {self = nil, Img_bottom = nil},
      Group_title = {
        self = nil,
        Img_income = {
          self = nil,
          Txt_title = nil,
          Txt_en = nil
        },
        Img_fate = {
          self = nil,
          Txt_num1 = nil,
          Txt_num2 = nil
        },
        Txt_operat = nil,
        Group_Psg = {self = nil, Txt_day = nil}
      },
      Group_information = {
        self = nil,
        Img_bottom = nil,
        Img_divide = {
          self = nil,
          Txt_divide = nil,
          Txt_num = nil
        },
        Group_circle = {
          self = nil,
          Img_bottom = nil,
          Group_original = {
            self = nil,
            Txt_original = nil,
            Txt_num = nil,
            Img_original = nil
          },
          Group_added = {
            self = nil,
            Txt_added = nil,
            Txt_num = nil,
            Img_added = nil
          },
          Group_maximum = {
            self = nil,
            Txt_ = nil,
            Group_ = nil
          },
          Group_tanhao = {
            self = nil,
            Img_tanhao = nil,
            Txt_ = nil,
            Btn_ = nil
          },
          Img_tanhao = {self = nil, Txt_ = nil},
          Group_Tips = {
            self = nil,
            Btn_Close = nil,
            Img_Btm = nil,
            Txt_Tips1 = nil
          }
        },
        Group_profit = {
          self = nil,
          Img_bg = nil,
          Img_today = {
            self = nil,
            Img_jinbi = {self = nil, Txt_num = nil},
            Txt_ = nil
          },
          Img_geduan1 = nil,
          Img_nextday = {
            self = nil,
            Img_jinbi = {self = nil, Txt_num = nil},
            Txt_ = nil
          },
          Img_geduan2 = nil,
          Img_tax = {
            self = nil,
            Txt_ = nil,
            Txt_num = nil
          },
          Group_Incomedata = {
            self = nil,
            Img_bg = nil,
            Img_tanhao = {self = nil, Txt_ = nil},
            Group_PriceShow = {
              self = nil,
              ScrollGrid_LIst = {
                self = nil,
                grid = {
                  self = nil,
                  Img_Moon = {self = nil, Txt_Moon = nil},
                  Group_Pillar = {
                    self = nil,
                    Img_Pillar = nil,
                    Txt_Num = nil
                  },
                  Group_Without = {
                    self = nil,
                    Img_Without = nil,
                    Txt_Without = nil
                  }
                }
              }
            },
            Group_unlocked = {
              self = nil,
              Img_bg = nil,
              Img_lockBottom = {
                self = nil,
                Img_lock = nil,
                Txt_ = nil
              }
            },
            Img_line = nil,
            Group_tanhao = {
              self = nil,
              Img_tanhao = nil,
              Txt_ = nil,
              Btn_ = nil
            },
            Group_data1 = {
              self = nil,
              Img_blackdata = {self = nil, Img_point = nil},
              Img_yellowdata = {self = nil, Img_yellowpoint = nil},
              Img_nextmonty = nil
            },
            Group_data2 = {
              self = nil,
              Img_blackdata = {self = nil, Img_point = nil},
              Img_yellowdata = {self = nil, Img_yellowpoint = nil},
              Img_nextmonty = nil
            },
            Group_data3 = {
              self = nil,
              Img_blackdata = {self = nil, Img_point = nil},
              Img_yellowdata = {self = nil, Img_yellowpoint = nil},
              Img_nextmonty = nil
            },
            Group_data4 = {
              self = nil,
              Img_blackdata = {self = nil, Img_point = nil},
              Img_yellowdata = {self = nil, Img_yellowpoint = nil},
              Img_nextmonty = nil
            },
            Group_data5 = {
              self = nil,
              Img_blackdata = {self = nil, Img_point = nil},
              Img_yellowdata = {self = nil, Img_yellowpoint = nil},
              Img_nextmonty = nil
            },
            Group_mark = {
              self = nil,
              Img_next = {self = nil, Txt_num = nil},
              Img_equal = {self = nil, Txt_num = nil},
              Img_present = {self = nil, Txt_num = nil}
            },
            Group_Tips = {
              self = nil,
              Btn_Close = nil,
              Img_Btm = nil,
              Txt_Tips1 = nil
            }
          }
        }
      },
      Group_income = {
        self = nil,
        Img_bg = nil,
        UI_leyuan_1_A = {
          self = nil,
          Liuguang = nil,
          Saoguang = nil
        },
        Group_progress = {
          self = nil,
          Txt_ = nil,
          Slider_progressBg = {
            self = nil,
            Img_Bg = nil,
            Img_processfull = nil,
            Img_needleProgress = nil,
            Img_needle1 = nil,
            Img_needle2 = nil
          },
          Group_basic1 = {
            self = nil,
            Img_undecide = {self = nil, Txt_ = nil},
            Img_decide = {self = nil, Txt_ = nil}
          },
          Group_basic2 = {
            self = nil,
            Img_undecide = {self = nil, Txt_ = nil},
            Img_decide = {self = nil, Txt_ = nil}
          },
          Group_basic3 = {
            self = nil,
            Img_undecide = {self = nil, Txt_ = nil},
            Img_decide = {self = nil, Txt_ = nil}
          },
          Txt_num1 = nil,
          Txt_num2 = nil,
          Txt_money = nil,
          month_profit = {
            self = nil,
            Img_profit = nil,
            Txt_ = nil
          }
        },
        Group_npc = {
          self = nil,
          Img_npc = nil,
          Img_talk = {
            self = nil,
            Txt_talk1 = nil,
            Txt_talk2 = nil,
            Txt_talk3 = nil
          }
        }
      },
      Img_ticketprofit = {
        self = nil,
        Txt_profit = {self = nil, Txt_ = nil},
        Group_profit = {
          self = nil,
          Img_jinbi = nil,
          Txt_money = nil
        },
        Txt_divide = nil
      },
      Btn_ = {self = nil, Txt_ = nil}
    },
    Group_Investment = {
      self = nil,
      glass = {self = nil, Img_bottom = nil},
      Img_investmenticon = {
        self = nil,
        Txt_num = {self = nil, Txt_ = nil},
        Txt_title = nil,
        Txt_investmentTime = nil
      },
      Group_information = {
        self = nil,
        Img_bg = nil,
        Group_grossInvestment = {
          self = nil,
          Txt_num = nil,
          Txt_ = nil
        },
        Group_divide = {
          self = nil,
          Txt_num = nil,
          Txt_ = nil
        },
        Group_tax = {
          self = nil,
          Txt_num = nil,
          Txt_ = nil
        },
        Group_ticket = {
          self = nil,
          Txt_num = nil,
          Txt_ = nil
        }
      },
      Group_progressbar = {
        self = nil,
        Txt_share = {
          self = nil,
          Txt_EN = nil,
          Img_ = nil,
          Txt_EN1 = nil
        },
        Group_progress = {
          self = nil,
          Img_bottom = {
            self = nil,
            Img_Progressbar = nil,
            Img_mask = nil,
            Group_award = {
              self = nil,
              Btn_CanReceive = {self = nil, Txt_ = nil},
              Btn_Received = {self = nil, Txt_ = nil},
              Btn_CantReceive = {self = nil, Txt_ = nil}
            }
          },
          Txt_num = nil
        }
      },
      ScrollGrid_List = {
        self = nil,
        grid = {
          self = nil,
          Img_bottom = {
            self = nil,
            Group_tx = {
              self = nil,
              UI_leyuan_Icon_Peak_Gold = {
                self = nil,
                Glow = nil,
                Particle = nil,
                Saoguang = nil,
                liuguang2 = nil
              },
              UI_leyuan_Icon_Peak_Mithril = {
                self = nil,
                Glow = nil,
                Particle = nil,
                Saoguang = nil,
                liuguang2 = nil
              },
              UI_leyuan_Icon_Peak_Platinum = {
                self = nil,
                Glow = nil,
                Particle = nil,
                Saoguang = nil,
                liuguang2 = nil
              },
              UI_leyuan_Icon_TypeA_Gold = {
                self = nil,
                Glow = nil,
                Particle = nil,
                Saoguang = nil,
                liuguang1 = nil
              },
              UI_leyuan_Icon_TypeB_Gold = {
                self = nil,
                Glow = nil,
                Particle = nil,
                Saoguang = nil,
                liuguang1 = nil
              },
              UI_leyuan_Icon_TypeC_Gold = {
                self = nil,
                Glow = nil,
                Particle = nil,
                Saoguang = nil,
                liuguang1 = nil
              }
            },
            Img_icon = nil,
            Txt_Title = nil,
            Img_level = {self = nil, Txt_ = nil},
            Txt_content = nil,
            Img_line = nil,
            Group_Reward = {
              self = nil,
              Group_RewardList = {
                self = nil,
                Group_Reward = {
                  self = nil,
                  Txt_ = nil,
                  Img_reward = nil,
                  Txt_reward = nil
                }
              },
              Group_RewardOther = {
                self = nil,
                Txt_Ticket = nil,
                Txt_Divide = nil,
                Txt_Rate = nil
              }
            },
            Btn_inverstment = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            },
            Img_lock = {
              self = nil,
              Img_ = nil,
              Txt_ = nil
            },
            Img_resources = {self = nil, Txt_ = nil}
          }
        }
      }
    },
    Group_Quest = {
      self = nil,
      glass = {self = nil, Img_bottom = nil},
      Img_ticketicon = {
        self = nil,
        Img_jinbi = {self = nil, Txt_num = nil},
        Txt_ = nil
      },
      Group_progressbar = {
        self = nil,
        tittle = {
          self = nil,
          Txt_share = nil,
          group_en = {
            self = nil,
            Txt_EN = nil,
            Img_ = nil,
            Txt_EN1 = nil
          }
        },
        Group_progress = {
          self = nil,
          Img_bottom = {
            self = nil,
            Img_Progressbar = nil,
            Img_mask = nil,
            Group_award = {
              self = nil,
              Btn_CanReceive = {
                self = nil,
                Txt_ = nil,
                UI_leyuan_libao_E = {
                  self = nil,
                  libao = nil,
                  lizi = nil,
                  beiguang = nil,
                  dian = nil
                }
              },
              Btn_Received = {self = nil, Txt_ = nil},
              Btn_CantReceive = {self = nil, Txt_ = nil}
            }
          },
          Txt_num = nil
        }
      },
      ScrollGrid_Quest = {
        self = nil,
        grid = {
          self = nil,
          Img_bottom = {self = nil, Img_subscript = nil},
          Img_questicon = {self = nil, Txt_dec = nil},
          Img_rewardbottom = {
            self = nil,
            Img_rewardicon = {self = nil, Txt_ = nil},
            ScrollGrid_Quest_Reward = {
              self = nil,
              grid = {
                self = nil,
                Img_Bottom = nil,
                Img_Item = nil,
                Img_Mask = nil,
                Btn_Item = nil
              }
            }
          },
          Group_questRight = {
            self = nil,
            Txt_ = nil,
            Img_progressBg = {
              self = nil,
              Img_processUnfull = nil,
              Img_processfull = nil
            },
            Img_sharde = nil,
            rewardGroup = {
              self = nil,
              Txt_ = nil,
              Img_reward = nil,
              Txt_reward = nil,
              Img_reward1 = nil,
              Txt_reward1 = nil
            },
            Group_btn = {
              self = nil,
              Btn_on = {
                self = nil,
                Txt_ = nil,
                Img_reached = nil
              },
              Btn_off = {
                self = nil,
                Txt_ = nil,
                Img_noreached = nil
              },
              Btn_end = {
                self = nil,
                Txt_ = nil,
                Img_noreached = nil
              }
            }
          },
          Group_end = {
            self = nil,
            Img_bg = nil,
            Img_icon = nil,
            Txt_ = nil,
            Txt_En = nil
          }
        }
      }
    },
    Group_TapBattle = {
      self = nil,
      Img_bottom = nil,
      Group_TicketProfit = {
        self = nil,
        Btn_on = {
          self = nil,
          Img_icon = nil,
          Txt_TicketProfit = nil
        },
        Btn_off = {
          self = nil,
          Img_icon = nil,
          Txt_TicketProfit = nil
        }
      },
      Group_Investment = {
        self = nil,
        Btn_on = {
          self = nil,
          Img_icon = nil,
          Txt_ = nil
        },
        Btn_off = {
          self = nil,
          Img_icon = nil,
          Txt_ = nil
        }
      },
      Group_Quest = {
        self = nil,
        Btn_on = {
          self = nil,
          Img_icon = nil,
          Txt_ = nil
        },
        Btn_off = {
          self = nil,
          Img_icon = nil,
          Txt_ = nil
        },
        Btn_lock = {
          self = nil,
          Img_icon = nil,
          Txt_ = nil
        }
      },
      GroupGold = {
        self = nil,
        Img_bg = nil,
        Img_Icon = nil,
        Txt_Num = nil,
        Btn_Add = nil
      },
      Btn_DonateNum = {
        self = nil,
        Img_ = nil,
        Txt_Num = nil,
        Btn_ = {self = nil, Txt_ = nil}
      },
      Btn_NextRefressh = {
        self = nil,
        Img_ = nil,
        Txt_Num = nil,
        Btn_ = nil
      },
      Btn_TicketRefressh = {
        self = nil,
        Img_ = nil,
        Txt_Num = nil,
        Btn_ = nil
      },
      Group_DonateTips = {
        self = nil,
        Btn_Close = nil,
        Img_Btm = nil,
        Txt_Tips1 = nil
      },
      Group_NextTips = {
        self = nil,
        Btn_Close = nil,
        Img_Btm = nil,
        Txt_Tips1 = nil
      },
      Group_TicketTips = {
        self = nil,
        Btn_Close = nil,
        Img_Btm = nil,
        Txt_Tips1 = nil
      }
    },
    Group_StageReward = {
      self = nil,
      Group_InvestStageReward = {
        self = nil,
        Img_BG = nil,
        Img_Btm = nil,
        Img_Btm2 = nil,
        Txt_Before = nil,
        Txt_After = nil,
        Txt_Title = nil,
        Img_Arrow = nil,
        Spine_Icon = nil,
        UI_tradePriceDownSuccess = {
          self = nil,
          Particle_Add_2 = nil,
          Particle_Add_3 = nil,
          Glow_Add1 = nil,
          Glow_Add2 = nil,
          Glow_Add3 = nil,
          Line_Add = nil,
          Flare = nil,
          Star_Bus = nil,
          Particle_Add_1 = nil
        }
      },
      Group_QuestStageReward = {
        self = nil,
        Img_BG = nil,
        Img_Btm = nil,
        Img_Btm2 = nil,
        Txt_Before = nil,
        Txt_After = nil,
        Txt_Title = nil,
        Img_Arrow = nil,
        Spine_Icon = nil,
        UI_tradePriceUpSuccess = {
          self = nil,
          Particle_Add_2 = nil,
          Particle_Add_3 = nil,
          Glow_Add = nil,
          Glow_Add1 = nil,
          Flare = nil,
          Particle_Add_3 = nil,
          Star_Bus = nil,
          Line_Add = nil
        }
      },
      Group_InvestReward = {
        self = nil,
        Img_BG = nil,
        Img_Btm = {
          self = nil,
          UI_leyun_Effect_Glow = {
            self = nil,
            Rotation = {
              self = nil,
              Glow1 = nil,
              Glow2 = nil
            }
          }
        },
        Txt_Title = nil,
        Group_Up = {
          self = nil,
          Img_Bg = nil,
          Group_Divide = {
            self = nil,
            Img_Icon = nil,
            Txt_Title = nil,
            Txt_Max = nil,
            Group_num = {
              self = nil,
              Txt_Num = nil,
              Img_UP = nil
            }
          },
          Group_build = {
            self = nil,
            Img_Icon = nil,
            Txt_Title = nil,
            Txt_Max = nil,
            Group_num = {
              self = nil,
              Txt_Num = nil,
              Img_UP = nil
            },
            Img_Line = nil
          },
          Group_Rate = {
            self = nil,
            Img_Icon = nil,
            Txt_Title = nil,
            Txt_Max = nil,
            Group_num = {
              self = nil,
              Txt_Num = nil,
              Img_UP = nil
            },
            Img_Line = nil
          },
          Group_Ticket = {
            self = nil,
            Img_Icon = nil,
            Txt_Title = nil,
            Txt_Max = nil,
            Group_num = {
              self = nil,
              Txt_Num = nil,
              Img_UP = nil
            },
            Img_Line = nil
          }
        },
        UI_leyuan_investUp = {
          self = nil,
          lizi = nil,
          FlashGlow = nil,
          Line = nil,
          Flare = nil,
          Glow = nil,
          Star = nil
        },
        Btn_Close = nil
      }
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
return HomeBattleCenter
