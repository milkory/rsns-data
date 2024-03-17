local env = {}
setmetatable(env, {
  __index = _G
})
setfenv(1, env)

function start()
end

function update()
end

function ondestroy()
end

return env
