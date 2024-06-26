program MyMoney;

uses
  System.StartUpCopy,
  FMX.Forms,
  untLogin in 'untLogin.pas' {frmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untLancamentos in 'untLancamentos.pas' {frmLancamentos},
  untLancamentosCad in 'untLancamentosCad.pas' {frmLancamentosCad},
  untCategorias in 'untCategorias.pas' {frmCategorias},
  untCategoriasCad in 'untCategoriasCad.pas' {frmCategoriaCad},
  DataModule.Principal in 'DataModules\DataModule.Principal.pas' {DMPrincipal: TDataModule},
  classCategoria in 'Classes\classCategoria.pas',
  uListViewLoader in 'Units\uListViewLoader.pas',
  classLancamento in 'Classes\classLancamento.pas',
  uFormat in 'Units\uFormat.pas',
  classLogin in 'Classes\classLogin.pas',
  untLancamentosResumo in 'untLancamentosResumo.pas' {frmLancamentoResumo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmLancamentoResumo, frmLancamentoResumo);
  Application.Run;
end.
