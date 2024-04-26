program MyMoney;

uses
  System.StartUpCopy,
  FMX.Forms,
  untLogin in 'untLogin.pas' {frmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untLancamentos in 'untLancamentos.pas' {frmLancamentos},
  untLancamentosCad in 'untLancamentosCad.pas' {frmLancamentosCad};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
