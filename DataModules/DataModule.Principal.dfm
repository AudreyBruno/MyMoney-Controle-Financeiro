object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 310
  Width = 444
  object FDConn: TFDConnection
    AfterConnect = FDConnAfterConnect
    BeforeConnect = FDConnBeforeConnect
    Left = 64
    Top = 40
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 128
    Top = 120
  end
end
