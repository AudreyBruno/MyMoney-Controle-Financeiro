unit DataModule.Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, System.IOUtils;

type
  TDMPrincipal = class(TDataModule)
    FDConn: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure FDConnBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMPrincipal.DataModuleCreate(Sender: TObject);
begin
  FDConn.Connected := True;
end;

procedure TDMPrincipal.FDConnAfterConnect(Sender: TObject);
begin
  FDConn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_CATEGORIA(' +
                 'ID_CATEGORIA INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                 'DESCRICAO VARCHAR (50), ' +
                 'ICONE BLOB, ' +
                 'INDICE_ICONE INTEGER);');

  FDConn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_LANCAMENTO(' +
                 'ID_LANCAMENTO INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                 'ID_CATEGORIA INTEGER REFERENCES TAB_CATEGORIA (ID_CATEGORIA), ' +
                 'VALOR DECIMAL (9, 2), ' +
                 'DATA DATE, ' +
                 'DESCRICAO VARCHAR (100));');

  FDConn.ExecSQL('CREATE TABLE IF NOT EXISTS TAB_USUARIO(' +
                 'ID_USUARIO INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                 'NOME VARCHAR (100), ' +
                 'EMAIL VARCHAR (100), ' +
                 'SENHA VARCHAR (100), ' +
                 'IND_LOGIN CHAR (1), ' +
                 'FOTO BLOB);');
end;

procedure TDMPrincipal.FDConnBeforeConnect(Sender: TObject);
begin
  FDConn.DriverName := 'SQLite';

  {$IFDEF MSWINDOWS}
    FDConn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\DB.db';
  {$ELSE}
    FDConn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'DB.db');
  {$ENDIF}
end;

end.
