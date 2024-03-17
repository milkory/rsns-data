local DataModel = {
  isReady = false,
  AnimIndex = 0,
  InitPos = {
    isRecord = true,
    x = 0,
    y = 0,
    scale = 1
  },
  Sound = nil,
  isSkip = false,
  AnimatorDelayList = {
    R = 55,
    R2 = 1,
    SR = 55,
    SR2 = 1,
    SSR = 55,
    SSR2 = 1,
    NewSR_J2 = 55,
    NewSR_J22 = 1,
    NewSSR_J2 = 55,
    NewSSR_J22 = 1,
    SR_J2 = 55,
    SR_J22 = 1,
    SSR_J2 = 55,
    SSR_J22 = 1
  }
}
return DataModel
