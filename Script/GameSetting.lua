local rt = {
  IsModuleActive = function(moduleName)
    if Setting ~= nil and Setting[moduleName] ~= nil then
      return Setting[moduleName]
    end
    return false
  end
}
return rt
