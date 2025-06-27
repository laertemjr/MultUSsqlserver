object dm: Tdm
  Height = 480
  Width = 640
  object ADOConnection1: TADOConnection
    ConnectionTimeout = 60
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 48
    Top = 32
  end
  object tbUsers: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 168
    Top = 32
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 264
    Top = 32
  end
end
