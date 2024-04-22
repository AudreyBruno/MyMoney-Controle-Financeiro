program MyMoney;

uses
  System.StartUpCopy,
  FMX.Forms,
  untLogin in 'untLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
