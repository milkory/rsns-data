function RegProperty(factoryName, properties)
  factory = CS.CBus.Instance:GetFactory(factoryName, false, true)
  
  if factory ~= nil then
    for i = 1, #properties do
      pro = properties[i]
      mod = pro.mod
      if mod == nil then
        mod = ""
      end
      name = pro.name
      if name == nil then
        name = "DefaultName"
      end
      pType = pro.type
      if pType == nil then
        pType = "String"
      end
      des = pro.des
      if des == nil then
        des = ""
      end
      isDarken = pro.isDarken
      if isDarken == nil then
        isDarken = false
      end
      pythonName = pro.pythonName
      if pythonName == nil then
        pythonName = ""
      end
      prthonType = pro.pythonType
      if pythonType == nil then
        pythonType = -1
      end
      detail = pro.detail
      if detail == nil then
        detail = ""
      end
      pyIgnore = pro.pyIgnore
      if pyIgnore == nil then
        pyIgnore = false
      end
      factory:RegPropertyOutside(mod, name, pType, des, pro.arg0, pro.arg1, isDarken, pythonName, pythonType, detail, pyIgnore)
    end
  end
end
