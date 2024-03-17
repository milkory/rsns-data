RegProperty("ActivityListFactory", {
  {
    mod = "城市列表",
    name = "stationList",
    type = "Array",
    des = "城市(车站)列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "城市(车站)",
    arg0 = "HomeStationFactory"
  },
  {name = "end"}
})
