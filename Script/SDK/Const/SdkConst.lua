local SdkConst = {}
SdkConst.EvtName = {
  login = "event_login",
  logout = "logout",
  create_role = "create_role",
  level_up = "level_up",
  guide_complete = "guide_complete",
  draw_card = "draw_card"
}
SdkConst.EvtProp = {
  id = "id",
  level = "level",
  level_before = "level_before"
}
SdkConst.EvtProp_DrawCard = {
  pond_id = "pond_id",
  draw_type = "draw_type",
  draw_num = "draw_num",
  get_item_info = "get_item_info"
}
SdkConst.ChannelType = {
  Default = 0,
  Bilibili = 1,
  Taptap = 2,
  Haoyou = 3
}
SdkConst.register_type = "register_type"
SdkConst.register_status = "register_status"
SdkConst.login_type = "login_type"
SdkConst.login_status = "login_status"
SdkConst.default = "default"
SdkConst.success = "success"
SdkConst.failed = "failed"
return SdkConst
