local LoginGV = {}
LoginGV.accessToken = ""
LoginGV.username = ""
LoginGV.isLoginChannel = false
LoginGV.isLogin = false

function LoginGV.SetAccessToken(token)
  LoginGV.accessToken = token
end

function LoginGV.GetAccessToken()
  return LoginGV.accessToken
end

function LoginGV.SetUsername(name)
  LoginGV.username = name
end

function LoginGV.GetUsername()
  return LoginGV.username
end

function LoginGV.IsLoginChannel()
  return LoginGV.isLoginChannel
end

function LoginGV.SetIsLoginChannel(v)
  LoginGV.isLoginChannel = v
end

function LoginGV.IsLogin()
  return LoginGV.isLogin
end

function LoginGV.SetIsLogin(v)
  LoginGV.isLogin = v
end

function LoginGV.OnChannelLogin(args)
  LoginGV.SetAccessToken(args.accessToken)
  LoginGV.SetUsername(args.username)
  LoginGV.SetIsLogin(true)
end

return LoginGV
