local PayGV = {}
PayGV.PAYTYPE_ALIPAY = 1
PayGV.PAYTYPE_WXPAY = 2
PayGV.CurPayType = PayGV.PAYTYPE_ALIPAY

function PayGV.IsCurPayTypeAlipay()
  return PayGV.CurPayType == PayGV.PAYTYPE_ALIPAY
end

function PayGV.IsCurPayTypeWx()
  return PayGV.CurPayType == PayGV.PAYTYPE_WXPAY
end

return PayGV
