local Setting = {
  self = nil,
  Btn_Close = nil,
  Img_Mask = {
    self = nil,
    Txt_Title = nil,
    Txt_TitleEn = nil,
    Img_SettingIcon = nil
  },
  Group_Tabs = {
    self = nil,
    StaticGrid_Tabs = {
      self = nil,
      grid = {
        self = nil,
        Btn_Off = {
          self = nil,
          Img_White = nil,
          Txt_Title = nil
        },
        Img_On = {
          self = nil,
          Img_Black = nil,
          Txt_Title = nil
        }
      }
    }
  },
  Group_Image = {
    self = nil,
    ScrollView_Image = {
      self = nil,
      Viewport = {
        self = nil,
        Content = {
          self = nil,
          Img_TitleBg = {
            self = nil,
            Txt_CN = nil,
            Txt_EN = nil
          },
          Btn_RestoreImage = {
            self = nil,
            Img_Rstore = nil,
            Txt_Restore = nil
          },
          Group_PictureQuality = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            StaticGrid_Quality = {
              self = nil,
              grid = {
                self = nil,
                Btn_Off = {
                  self = nil,
                  Txt_Title = nil,
                  Txt_Desc = nil,
                  Img_Off = nil
                },
                Img_Selection = {
                  self = nil,
                  Txt_Title = nil,
                  Txt_Desc = nil,
                  Img_On = nil
                }
              }
            }
          },
          Group_TextureQuality = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Box = {
              self = nil,
              StaticGrid_TextureQuality = {
                self = nil,
                grid = {
                  self = nil,
                  Btn_Off = {
                    self = nil,
                    Img_Off = nil,
                    Txt_Title = nil
                  },
                  Img_On = {
                    self = nil,
                    Img_On = nil,
                    Txt_Title = nil
                  }
                }
              },
              Group_Line = {
                self = nil,
                Img_Line1 = nil,
                Img_Line2 = nil,
                Img_Line3 = nil
              }
            }
          },
          Group_CityFPS = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Box = {
              self = nil,
              Img_Line = nil,
              Group_30Fps = {
                self = nil,
                Btn_Off = {
                  self = nil,
                  Txt_30 = nil,
                  Img_Off = nil
                },
                Img_On = {
                  self = nil,
                  Txt_30 = nil,
                  Img_On = nil
                }
              },
              Group_60Fps = {
                self = nil,
                Btn_Off = {
                  self = nil,
                  Txt_60 = nil,
                  Img_Off = nil
                },
                Img_On = {
                  self = nil,
                  Txt_60 = nil,
                  Img_On = nil
                }
              }
            }
          },
          Group_DriveFPS = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Box = {
              self = nil,
              Img_Line = nil,
              Group_30Fps = {
                self = nil,
                Btn_Off = {
                  self = nil,
                  Txt_30 = nil,
                  Img_Off = nil
                },
                Img_On = {
                  self = nil,
                  Txt_30 = nil,
                  Img_On = nil
                }
              },
              Group_60Fps = {
                self = nil,
                Btn_Off = {
                  self = nil,
                  Txt_60 = nil,
                  Img_Off = nil
                },
                Img_On = {
                  self = nil,
                  Txt_60 = nil,
                  Img_On = nil
                }
              }
            }
          },
          Group_DriveHorizon = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Box = {
              self = nil,
              StaticGrid_DriveHorizon = {
                self = nil,
                grid = {
                  self = nil,
                  Btn_Off = {
                    self = nil,
                    Img_Off = nil,
                    Txt_Title = nil
                  },
                  Img_On = {
                    self = nil,
                    Img_On = nil,
                    Txt_Title = nil
                  }
                }
              },
              Group_Line = {
                self = nil,
                Img_Line1 = nil,
                Img_Line2 = nil,
                Img_Line3 = nil,
                Img_Line4 = nil
              }
            }
          },
          Group_DriveShadow = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Switch = {
              self = nil,
              Txt_Off = nil,
              Txt_On = nil,
              Img_On = nil,
              Btn_Click = nil
            }
          },
          Group_Bloom = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Switch = {
              self = nil,
              Txt_Off = nil,
              Txt_On = nil,
              Img_On = nil,
              Btn_Click = nil
            }
          },
          Group_Anti_Aliasing = {
            self = nil,
            Img_Bg = nil,
            Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
            Img_Dot = nil,
            Txt_Title = nil,
            Txt_Desc = nil,
            Img_Switch = {
              self = nil,
              Txt_Off = nil,
              Txt_On = nil,
              Img_On = nil,
              Btn_Click = nil
            }
          }
        }
      },
      Scrollbar_Vertical = {
        self = nil,
        Sliding_Area = {self = nil, Img_Handle = nil}
      }
    }
  },
  Group_Sound = {
    self = nil,
    Img_TitleBg = {
      self = nil,
      Txt_CN = nil,
      Txt_EN = nil
    },
    Group_MusicVolume = {
      self = nil,
      Img_Bg = nil,
      Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
      Img_Dot = nil,
      Txt_Title = nil,
      Txt_Desc = nil,
      Img_Box = {
        self = nil,
        Slider_MusicVolume = {
          self = nil,
          Img_Bg = nil,
          Group_Fill = {self = nil, Img_Fill = nil},
          Group_Handle = {self = nil, Img_Handle = nil},
          Group_Base = {
            self = nil,
            Img_Mute = nil,
            Img_Max = nil,
            Img_SoundValue = {self = nil, Txt_ = nil}
          }
        }
      }
    },
    Group_EffectVolume = {
      self = nil,
      Img_Bg = nil,
      Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
      Img_Dot = nil,
      Txt_Title = nil,
      Txt_Desc = nil,
      Img_Box = {
        self = nil,
        Slider_MusicVolume = {
          self = nil,
          Img_Bg = nil,
          Group_Fill = {self = nil, Img_Fill = nil},
          Group_Handle = {self = nil, Img_Handle = nil},
          Group_Base = {
            self = nil,
            Img_Max = nil,
            Img_Mute = nil,
            Img_SoundValue = {self = nil, Txt_ = nil}
          }
        }
      }
    },
    Group_DubbingOptions = {
      self = nil,
      Img_Bg = nil,
      Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
      Img_Dot = nil,
      Txt_Title = nil,
      Txt_Desc = nil,
      Img_Box = {
        self = nil,
        Group_Chinese = {
          self = nil,
          Group_Language = {
            self = nil,
            Btn_Off = {
              self = nil,
              Img_Off = nil,
              Txt_30 = nil
            },
            Img_On = {
              self = nil,
              Img_On = nil,
              Txt_30 = nil
            }
          },
          Img_Line = nil
        },
        Group_Japanese = {
          self = nil,
          Group_Language = {
            self = nil,
            Btn_Off = {
              self = nil,
              Img_Off = nil,
              Txt_30 = nil
            },
            Img_On = {
              self = nil,
              Img_On = nil,
              Txt_30 = nil
            }
          },
          Img_Line = nil
        }
      }
    },
    Group_CvVolume = {
      self = nil,
      Img_Bg = nil,
      Img_EnglishBg = {self = nil, Txt_EnglishTitle = nil},
      Img_Dot = nil,
      Txt_Title = nil,
      Txt_Desc = nil,
      Img_Box = {
        self = nil,
        Slider_MusicVolume = {
          self = nil,
          Img_Bg = nil,
          Group_Fill = {self = nil, Img_Fill = nil},
          Group_Handle = {self = nil, Img_Handle = nil},
          Group_Base = {
            self = nil,
            Img_Max = nil,
            Img_Mute = nil,
            Img_SoundValue = {self = nil, Txt_ = nil}
          }
        }
      }
    },
    Btn_RestoreImage = {
      self = nil,
      Img_Rstore = nil,
      Txt_Restore = nil
    }
  },
  Group_ImageQuality = {
    self = nil,
    Txt_Title = nil,
    Btn_VeryLow = {self = nil, Txt_ = nil},
    Btn_Low = {self = nil, Txt_ = nil},
    Btn_Medium = {self = nil, Txt_ = nil},
    Btn_High = {self = nil, Txt_ = nil},
    Btn_VeryHigh = {self = nil, Txt_ = nil}
  },
  Group_FPS = {
    self = nil,
    Txt_Title = nil,
    Btn_30 = {self = nil, Txt_ = nil},
    Btn_60 = {self = nil, Txt_ = nil}
  },
  Group_Shadow = {
    self = nil,
    Txt_Title = nil,
    Btn_On = {self = nil, Txt_ = nil},
    Btn_Off = {self = nil, Txt_ = nil}
  },
  Group_Tips = {
    self = nil,
    Img_Tips = nil,
    Txt_Tips = nil
  },
  Group_TextureQuality = {
    self = nil,
    Txt_Title = nil,
    Btn_Low = {self = nil, Txt_ = nil},
    Btn_Medium = {self = nil, Txt_ = nil},
    Btn_High = {self = nil, Txt_ = nil}
  },
  Group_Horizon = {
    self = nil,
    Txt_Title = nil,
    Btn_VeryClose = {self = nil, Txt_ = nil},
    Btn_Close = {self = nil, Txt_ = nil},
    Btn_Medium = {self = nil, Txt_ = nil},
    Btn_Far = {self = nil, Txt_ = nil}
  },
  Group_Bloom = {
    self = nil,
    Txt_Title = nil,
    Btn_On = {self = nil, Txt_ = nil},
    Btn_Off = {self = nil, Txt_ = nil}
  },
  Group_Slider1 = {
    self = nil,
    Img_Bottom = nil,
    Slider_Value1 = {
      self = nil,
      Img_Bg = nil,
      Group_Handle = {
        self = nil,
        Img_Handle = {self = nil, Img_ = nil},
        Img_SoundValue = {self = nil, Txt_ = nil}
      }
    },
    Txt_Title = nil
  },
  Group_Slider2 = {
    self = nil,
    Img_Bottom = nil,
    Slider_Value2 = {
      self = nil,
      Img_Bg = nil,
      Group_Handle = {
        self = nil,
        Img_Handle = {self = nil, Img_ = nil},
        Img_SoundValue = {self = nil, Txt_ = nil}
      }
    },
    Txt_Title = nil
  },
  Group_Cdk = {
    self = nil,
    Img_TitleBg = {
      self = nil,
      Txt_CN = nil,
      Txt_EN = nil
    },
    Btn_RestoreImage = {
      self = nil,
      Img_Rstore = nil,
      Txt_Restore = nil
    },
    Img_Bg = nil,
    Img_Dot = nil,
    Txt_Title = nil,
    Img_Input = {
      self = nil,
      InputField_Cdk = {
        self = nil,
        Placeholder = nil,
        Txt_Name = nil
      },
      Btn_Clean = {
        self = nil,
        Group_Clean = {
          self = nil,
          Img_Clean = nil,
          Txt_Clean = nil
        }
      }
    },
    Group_Nocite = {
      self = nil,
      Img_Nocite = nil,
      Txt_Nocite = nil
    },
    Btn_Convert = {self = nil, Txt_Convert = nil}
  }
}
return Setting
