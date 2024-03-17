local Quest = {
  self = nil,
  Img_BG = nil,
  Img_Blur = nil,
  Img_B = nil,
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Group_Txt = {
        self = nil,
        icon = nil,
        Txt_ = nil
      }
    },
    Group_Help = {
      self = nil,
      bg = nil,
      Group_Tips = {
        self = nil,
        Img_Tips = nil,
        Txt_Tips = nil
      },
      Group_window = {
        self = nil,
        bg = nil,
        Group_title = {
          self = nil,
          Img_icon = nil,
          Txt_title = nil
        },
        Group_txt = {self = nil, Txt_ = nil},
        Group_tabList = {
          self = nil,
          ScrollGrid_list = {
            self = nil,
            grid = {
              self = nil,
              Group_on = {
                self = nil,
                bg = nil,
                Txt_ = nil
              },
              Group_off = {self = nil, Txt_ = nil}
            }
          }
        }
      }
    }
  },
  Group_Info = {
    self = nil,
    Img_LeftTitle = nil,
    Txt_Name = nil,
    Txt_Position = {self = nil, Img_P = nil},
    Img_Target = nil,
    Img_Arrow = nil,
    Txt_Target = nil,
    Txt_TargetNum = nil,
    ScrollView_Des = {
      self = nil,
      Viewport = {self = nil, Txt_Des = nil}
    },
    Img_R = nil,
    Txt_R = nil,
    Img_RewardBG = nil,
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
          Img_Effect = nil,
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
          }
        }
      }
    },
    Group_Btn = {
      self = nil,
      Btn_Cancel = {
        self = nil,
        Img_ = nil,
        Txt_ = nil
      },
      Btn_Navigate = {
        self = nil,
        Img_Navigate = nil,
        Txt_Navigate = nil
      },
      Btn_CancelNavigate = {
        self = nil,
        Img_CancelNavigate = nil,
        Txt_CancelNavigate = nil
      }
    },
    Group_Order = {
      self = nil,
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
      },
      Group_Submit = {
        self = nil,
        Img_ = nil,
        Img_1 = nil,
        Txt_ = nil
      },
      Img_ = nil,
      Txt_ = nil
    }
  },
  Group_Null = {self = nil, Txt_ = nil},
  ScrollView_QuestList = {
    self = nil,
    Viewport = {
      self = nil,
      Content = {
        self = nil,
        Btn_MainQuest = {
          self = nil,
          Img_Icon = nil,
          Txt_ = nil,
          Group_UnSelected = {self = nil, Img_Arrow = nil},
          Group_Selected = {
            self = nil,
            Img_S = nil,
            Img_Arrow = nil
          },
          Img_New = nil
        },
        ScrollGrid_MainQuest = {
          self = nil,
          grid = {
            self = nil,
            Btn_Quest = {
              self = nil,
              Txt_Name = nil,
              Txt_OrderName = nil,
              Img_Target = nil,
              Txt_Position = {self = nil, Img_P = nil},
              Group_Submit = {
                self = nil,
                Img_1 = nil,
                Txt_ = nil
              },
              Group_Selected = {
                self = nil,
                Img_bg = nil,
                Txt_Name = nil,
                Txt_OrderName = nil,
                Img_icon = nil,
                Img_Target = nil,
                Group_Submit = {
                  self = nil,
                  Img_1 = nil,
                  Txt_ = nil
                },
                Txt_Position = {self = nil, Img_P = nil}
              }
            },
            Img_New = nil
          }
        },
        Btn_SideQuest = {
          self = nil,
          Img_Icon = nil,
          Txt_ = nil,
          Group_UnSelected = {self = nil, Img_Arrow = nil},
          Group_Selected = {
            self = nil,
            Img_S = nil,
            Img_Arrow = nil
          },
          Img_New = nil
        },
        ScrollGrid_SideQuest = {
          self = nil,
          grid = {
            self = nil,
            Btn_Quest = {
              self = nil,
              Txt_Name = nil,
              Txt_OrderName = nil,
              Img_Target = nil,
              Txt_Position = {self = nil, Img_P = nil},
              Group_Submit = {
                self = nil,
                Img_1 = nil,
                Txt_ = nil
              },
              Group_Selected = {
                self = nil,
                Img_bg = nil,
                Txt_Name = nil,
                Txt_OrderName = nil,
                Img_icon = nil,
                Img_Target = nil,
                Group_Submit = {
                  self = nil,
                  Img_1 = nil,
                  Txt_ = nil
                },
                Txt_Position = {self = nil, Img_P = nil}
              }
            },
            Img_New = nil
          }
        },
        Btn_COCQuest = {
          self = nil,
          Img_Icon = nil,
          Txt_ = nil,
          Group_UnSelected = {self = nil, Img_Arrow = nil},
          Group_Selected = {
            self = nil,
            Img_S = nil,
            Img_Arrow = nil
          },
          Img_New = nil
        },
        ScrollGrid_COCQuest = {
          self = nil,
          grid = {
            self = nil,
            Btn_Quest = {
              self = nil,
              Txt_Name = nil,
              Txt_OrderName = nil,
              Img_Target = nil,
              Txt_Position = {self = nil, Img_P = nil},
              Group_Submit = {
                self = nil,
                Img_1 = nil,
                Txt_ = nil
              },
              Group_Selected = {
                self = nil,
                Img_bg = nil,
                Txt_Name = nil,
                Txt_OrderName = nil,
                Img_icon = nil,
                Img_Target = nil,
                Group_Submit = {
                  self = nil,
                  Img_1 = nil,
                  Txt_ = nil
                },
                Txt_Position = {self = nil, Img_P = nil}
              }
            },
            Img_New = nil
          }
        },
        Btn_OrderQuest = {
          self = nil,
          Img_Icon = nil,
          Txt_ = nil,
          Group_UnSelected = {self = nil, Img_Arrow = nil},
          Group_Selected = {
            self = nil,
            Img_S = nil,
            Img_Arrow = nil
          },
          Img_New = nil
        },
        ScrollGrid_OrderQuest = {
          self = nil,
          grid = {
            self = nil,
            Btn_Quest = {
              self = nil,
              Txt_Name = nil,
              Txt_OrderName = nil,
              Img_Target = nil,
              Group_Submit = {
                self = nil,
                Img_1 = nil,
                Txt_ = nil
              },
              Group_Selected = {
                self = nil,
                Img_bg = nil,
                Txt_Name = nil,
                Txt_OrderName = nil,
                Img_icon = nil,
                Img_Target = nil,
                Group_Submit = {
                  self = nil,
                  Img_1 = nil,
                  Txt_ = nil
                },
                Txt_Position = {self = nil, Img_P = nil}
              },
              Txt_Position = {self = nil, Img_P = nil}
            },
            Img_New = nil
          }
        }
      }
    }
  },
  Scrollbar_Vertical = {
    self = nil,
    Sliding_Area = {self = nil, Handle = nil}
  }
}
return Quest
