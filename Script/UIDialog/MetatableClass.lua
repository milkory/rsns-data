local Class = {}
local tableClassNames = {}
local New = function(className, super)
  assert(type(className) == "string" and 0 < #className)
  assert(tableClassNames[className] == nil, "Try to redefine a class with name : [" .. className .. "]")
  local tableNewClass = {}
  tableNewClass.className = className
  tableNewClass.super = super
  tableNewClass.category = "Class"
  tableNewClass.Ctor = false
  tableNewClass.Dtor = false
  tableNewClass.__index = super
  setmetatable(tableNewClass, tableNewClass)
  
  function tableNewClass.New(...)
    local tableNewObject = {type = tableNewClass, category = "Instance"}
    tableNewObject.__index = tableNewClass
    setmetatable(tableNewObject, tableNewObject)
    do
      local Create
      
      function Create(class, ...)
        if type(class.super) == "table" then
          Create(class.super, ...)
        end
        if type(class.Ctor) == "function" then
          class.Ctor(tableNewObject, ...)
        end
      end
      
      Create(tableNewClass, ...)
    end
    
    function tableNewObject:Dispose()
      local currentClass = self.type
      while currentClass ~= nil do
        if type(currentClass.Dtor) == "function" then
          currentClass.Dtor(self)
        end
        currentClass = currentClass.super
      end
    end
    
    return tableNewObject
  end
  
  tableClassNames[className] = tableNewClass
  return tableNewClass
end
Class.New = New
return Class
