local WeaponCreate = {
  self = nil,
  Img_BGMask = nil,
  Img_Backgroud = nil,
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
    Btn_Talk = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    },
    Btn_Create = {
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
      Img_ = nil,
      Txt_ = nil,
      Img_1 = nil
    }
  },
  Group_WeaponList = {
    self = nil,
    Img_Bg = {self = nil, Img_Design = nil},
    Group_Top = {
      self = nil,
      Img_TittleBg = {
        self = nil,
        Img_Icon = nil,
        Txt_Name = nil,
        Txt_Eng = nil
      }
    },
    Group_List = {
      self = nil,
      Group_Left = {
        self = nil,
        Img_Bg = {
          self = nil,
          Group_Page = {
            self = nil,
            StaticGrid_Page = {
              self = nil,
              grid = {
                self = nil,
                Btn_Page = {
                  self = nil,
                  Img_OFF = {self = nil, Txt_OFF = nil},
                  Img_ON = {self = nil, Txt_ON = nil}
                }
              }
            },
            Group_Page = {
              self = nil,
              Btn_Page = {
                self = nil,
                Img_OFF = {self = nil, Txt_OFF = nil},
                Img_ON = {self = nil, Txt_ON = nil}
              }
            }
          },
          ScrollGrid_Item = {
            self = nil,
            grid = {
              self = nil,
              Img_WeaponItem = {
                self = nil,
                Group_WeaponItem = {
                  self = nil,
                  Img_Bg = nil,
                  Img_Mask = {self = nil, Img_Item = nil},
                  Group_Type = {
                    self = nil,
                    Img_Type = nil,
                    Txt_Type = nil
                  },
                  Img_Rare = nil,
                  Img_Zhuangshi = nil,
                  Txt_Name = nil
                }
              },
              Img_Select = nil,
              Btn_Button = nil
            }
          }
        }
      },
      Group_Right = {
        self = nil,
        NewScrollGrid_List = {
          self = nil,
          grid = {
            self = nil,
            Group_WeaponItem = {
              self = nil,
              Img_Bg = nil,
              Img_Rare = nil,
              Txt_Name = nil,
              Img_Mask = {self = nil, Img_Item = nil},
              Group_Type = {
                self = nil,
                Img_Type = nil,
                Txt_Type = nil
              },
              Img_Shadow = {
                self = nil,
                Img_Icon = nil,
                Txt_Tips = nil
              },
              Btn_Button = nil,
              Img_Line = nil
            }
          }
        }
      }
    },
    Group_Create = {
      self = nil,
      Group_Left = {
        self = nil,
        Img_Circle = {self = nil, Img_Weapon = nil},
        Group_RareAndName = {
          self = nil,
          Img_Rare = nil,
          Txt_Name = nil
        },
        StaticGrid_Item = {
          self = nil,
          grid = {
            self = nil,
            Img_Kuang = nil,
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
              },
              Group_Num = {
                self = nil,
                Txt_Have = nil,
                Txt_And = nil,
                Txt_Need = nil
              }
            }
          }
        },
        Group_Item = {
          self = nil,
          Img_Kuang = nil,
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
            },
            Group_Num = {
              self = nil,
              Txt_Have = nil,
              Txt_And = nil,
              Txt_Need = nil
            }
          }
        },
        Img_Type = {self = nil, Txt_Type = nil}
      },
      Group_Right = {
        self = nil,
        Txt_Title = nil,
        Btn_Button = {
          self = nil,
          Img_OFF = {self = nil, Txt_Yulan = nil},
          Img_ON = {self = nil, Txt_Yulan = nil}
        },
        ScrollView_Entry = {
          self = nil,
          Viewport = {
            self = nil,
            Content = {
              self = nil,
              Group_MonsterType = {
                self = nil,
                Img_MonsterType = {
                  self = nil,
                  Txt_Text = nil,
                  Txt_English = nil
                },
                Group_Type1 = {
                  self = nil,
                  Img_Type = {
                    self = nil,
                    Img_Icon = nil,
                    Txt_Name = nil
                  }
                },
                Group_Type2 = {
                  self = nil,
                  Img_Type = {
                    self = nil,
                    Img_Icon = nil,
                    Txt_Name = nil
                  }
                },
                Group_Type3 = {
                  self = nil,
                  Img_Type = {
                    self = nil,
                    Img_Icon = nil,
                    Txt_Name = nil
                  }
                },
                Group_Type4 = {
                  self = nil,
                  Img_Type = {
                    self = nil,
                    Img_Icon = nil,
                    Txt_Name = nil
                  }
                },
                Group_Type5 = {
                  self = nil,
                  Img_Type = {
                    self = nil,
                    Img_Icon = nil,
                    Txt_Name = nil
                  }
                },
                Group_Type6 = {
                  self = nil,
                  Img_Type = {
                    self = nil,
                    Img_Icon = nil,
                    Txt_Name = nil
                  }
                }
              },
              Group_BaseTitle = {
                self = nil,
                Img_BaseTitle = {
                  self = nil,
                  Txt_Text = nil,
                  Txt_English = nil
                },
                Group_BaseEntry1 = {
                  self = nil,
                  Img_bg = nil,
                  Img_Icon = nil,
                  Txt_Entry = nil,
                  Img_Num = {self = nil, Txt_Num = nil}
                },
                Group_BaseEntry2 = {
                  self = nil,
                  Img_bg = nil,
                  Img_Icon = nil,
                  Txt_Entry = nil,
                  Img_Num = {self = nil, Txt_Num = nil}
                }
              },
              Group_SpecialTitle = {
                self = nil,
                Img_SpecialTitle = {
                  self = nil,
                  Txt_Text = nil,
                  Txt_English = nil
                },
                Group_SpecialEntry1 = {
                  self = nil,
                  Img_Icon = nil,
                  Txt_Entry = nil
                },
                Group_SpecialEntry2 = {
                  self = nil,
                  Img_Icon = nil,
                  Txt_Entry = nil
                },
                Group_SpecialEntry3 = {
                  self = nil,
                  Img_Icon = nil,
                  Txt_Entry = nil
                },
                Group_SpecialEntry4 = {
                  self = nil,
                  Img_Icon = nil,
                  Txt_Entry = nil
                }
              }
            }
          }
        },
        Btn_Build = {
          self = nil,
          Img_Build = nil,
          Txt_Build = nil,
          Img_Gold = nil,
          Txt_Gold = nil
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
  },
  Group_Ding = {
    self = nil,
    Btn_YN = {
      self = nil,
      Img_Icon = nil,
      Txt_Num = nil,
      Btn_Add = nil
    }
  },
  Btn_Skip = {
    self = nil,
    Img_ = nil,
    Txt = nil
  }
}
return WeaponCreate
