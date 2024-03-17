local Order = {}

function Order:OnStart(ca)
  if TrainCameraManager.SetCameraDragEnable then
    TrainCameraManager:SetCameraDragEnable(ca.cameraType, ca.moveCam)
  end
  if TrainCameraManager.SetCameraClickObjEnable then
    TrainCameraManager:SetCameraClickObjEnable(ca.cameraType, ca.clickCam)
  end
end

function Order:IsFinish()
  return true
end

return Order
