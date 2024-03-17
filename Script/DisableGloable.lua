local declaredNames = {}

function declare(name, initval)
  rawset(_G, name, initval)
  declaredNames[name] = true
end

setmetatable(_G, {
  __newindex = function(t, n, v)
    if not declaredNames[n] then
      error("尝试写入未声明的全局变量: " .. n, 2)
    else
      rawset(t, n, v)
    end
  end,
  __index = function(_, n)
    if not declaredNames[n] then
      error("尝试读取未声明的全局变量: " .. n, 2)
    else
      return nil
    end
  end
})
